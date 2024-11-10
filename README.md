# Amazon EC2 Instance Deployment
### Overview
This lab demonstrates how to deploy a simple web application on an Amazon Linux EC2 instance using Terraform. The lab focuses on creating a virtual network, launching an EC2 instance, installing a web server, and deploying an HTML page.

### Prerequisites
*AWS CLI configured with credentials*: Make sure your AWS credentials (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) are configured on your machine. You can set them up using:
`aws configure`
Ensure you have permissions to create EC2 instances, VPCs, and related resources.
*Terraform Installed*: Download Terraform and ensure it is added to your system's PATH.
#### Objectives
By completing this lab, you will:
* Configure a virtual private cloud (VPC) and subnet.
* Launch an Amazon Linux EC2 instance within this virtual network.
* Install and configure an Apache HTTP web server.
* Deploy and view a sample HTML page in a web browser.

#### Steps
1. Configure the Network
Define a VPC and subnet using Terraform.
Associate a public IP to the EC2 instance for access over the internet.

2. Launch the EC2 Instance
Use an Amazon Linux AMI with a t3.micro instance type.
Auto-assign a public IPv4 address to the instance.

3. Set Up the Web Server
In the user_data section of the Terraform configuration, install and start the Apache HTTP server (httpd) and set permissions for the document root directory.

4. Deploy the HTML Page
After launching the instance, use EC2 Instance Connect to access the server.
Create a file named projects.html in the /var/www/html directory with the following content:

`<!DOCTYPE html><html><body><h1>[Your Name]'s re/Start Project Work</h1><p>EC2 Instance Challenge Lab</p></body></html>`

Replace [Your Name] with your actual name.

5. Verify and Capture Output
Access http://[your-instance-public-ip]/projects.html in a web browser to confirm the setup.
Capture a screenshot of the webpage:

![webserver](https://github.com/user-attachments/assets/376aa26f-6bef-4a73-a72c-db77967bd4a2)

#### Running the Terraform Code
To deploy the resources, navigate to the directory containing main.tf and follow these commands:
Initialize Terraform (downloads necessary providers and sets up the environment):

Clone the repository (to get the Terraform files):
`git clone https://github.com/MaayanAimelak28/Canvas-Lab-172--Challenge--Linux-EC2-Instance.git`

Navigate to the project directory:
`cd canvas_terraform`

Initialize Terraform (downloads necessary providers and sets up the environment):
`terraform init`

Apply the Configuration (creates the resources):
`terraform apply`
Type `yes` when prompted to confirm.

Clean Up Resources (when finished, destroy resources to avoid unwanted charges):
`terraform destroy`
