# Amazon EC2 Instance Deployment with Terraform
### Overview
This lab demonstrates how to deploy a simple web application on an Amazon Linux EC2 instance using Terraform. The implementation focuses on creating a complete network infrastructure and deploying a basic web server.
### Prerequisites
- **AWS Account**: Active AWS account with appropriate permissions
- **AWS CLI**: Configured with credentials:
`aws configure`
- **Terraform**: Version 1.0 or later installed and added to PATH
- **Git**: For cloning the repository
  
#### Objectives
By completing this lab, you will:
* Set up a complete VPC infrastructure with:
Custom VPC
Public subnet
Internet Gateway
Route table
Security group
* Deploy an Amazon Linux EC2 instance
* Configure and deploy Apache web server
* Serve custom HTML content
  
#### Technical Details
Infrastructure Components:
* VPC: 10.0.0.0/16 CIDR block
* Subnet: Public subnet in us-west-2a
* Security Group:
Inbound rules: HTTP (80), SSH (22)
Outbound rules: All traffic
* EC2 Instance: t3.micro with Amazon Linux 2023

#### Deployment Steps
1. Clone the Repository:

`git clone https://github.com/MaayanAimelak28/Canvas-Lab-172--Challenge--Linux-EC2-Instance.git`

`cd canvas_terraform`

2. Configure AWS Credentials:

`export AWS_ACCESS_KEY_ID="your-access-key"`

`export AWS_SECRET_ACCESS_KEY="your-secret-key"`

3. Initialize and Apply Terraform:

`terraform init`

`terraform plan    # Review the changes`

`terraform apply   # Type 'yes' when prompted`

4. Verify Deployment:
* Once deployment is complete, Terraform will output the public IP.
* Access the web server:
- **Main page**: http://<public-ip>
- **Projects page**: http://<public-ip>/projects.html
  
![webserver](https://github.com/user-attachments/assets/e8fc733a-e8cf-4cbf-b7ce-d384c9a08524)


5.Clean Up:

`terraform destroy  # Type 'yes' when prompted`

#### Troubleshooting
If the web page is not accessible:

1. Check the instance security group
2. Verify the instance is running
3. Check Apache service status:
`systemctl status httpd`
4. Review Apache logs:
`sudo tail -f /var/log/httpd/error_log`
