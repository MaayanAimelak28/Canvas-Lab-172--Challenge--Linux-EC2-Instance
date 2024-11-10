provider "aws" {
  region = "us-west-2" 
}

# Create a new VPC
resource "aws_vpc" "web_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway for VPC
resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id
}

# Create a new Subnet
resource "aws_subnet" "web_subnet" {
  vpc_id                   = aws_vpc.web_vpc.id
  cidr_block               = "10.0.1.0/24"
  map_public_ip_on_launch  = true
  availability_zone        = "us-west-2a" 
}

# Create a Route Table
resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "web_rta" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rt.id
}

# Create a Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  vpc_id      = aws_vpc.web_vpc.id
  description = "Allow HTTP and SSH"

  # Allow HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch the EC2 instance
resource "aws_instance" "web_server" {
  ami                    = "ami-066a7fbea5161f451" 
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.web_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id] 
  associate_public_ip_address = true

  # User data script to install and start httpd
  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Set the permissions for the directory
chmod 777 /var/www/html

# Create and write to projects.html
echo '<!DOCTYPE html><html><body><h1>Maayan Aimelak'\''s re/Start Project Work</h1><p>EC2 Instance Challenge Lab</p></body></html>' > /var/www/html/projects.html
chmod 777 /var/www/html/projects.html

# Create and write to index.html
echo "<html><body><h1>Hello from Terraform</h1></body></html>" > /var/www/html/index.html
EOF

  # Root volume configuration
  root_block_device {
    volume_type = "gp2"
  }

  tags = {
    Name = "My Web Server"
  }
}

# Output instance public IP for SSH connection
output "instance_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP of the web server for SSH connection"
}

