PROG 8870 -- Final Project: Deploying AWS Infrastructure with Terraform and
CloudFormation
Title: AWS Infrastructure Automation with Terraform and CloudFormation
Overview
In this project, students will utilize Terraform and CloudFormation to create a scalable AWS
infrastructure. The project will demonstrate a multi-service environment including S3
Buckets, EC2 Instances, and RDS
Database Instances, applying Infrastructure as Code (IaC) best practices across diLerent
tools.
Project Scope
You are required to complete deployment tasks across six modules using Terraform and
CloudFormation, ensuring:

- Private and secure AWS storage and compute resources.
- Automated and modular infrastructure.
- Proper documentation, reusability, and dynamic configuration.
- A live demo showcasing resource provisioning.
  Tasks and Deliverables:

1. S3 Bucket Setup

- Using Terraform:
  o Create 4 Private S3 Buckets without public access.
  o Enable versioning on all buckets (Bonus Challenge).
- Using CloudFormation:
  o Create 3 Private S3 Buckets with PublicAccessBlockConfiguration.
  o Enable versioning on all buckets (Bonus Challenge

2. VPC and EC2 Instance

- Using Terraform:
  o Set up an EC2 instance inside a custom VPC.
  o Use dynamic variables for AMI ID and instance type.
  o Enable public IP and allow SSH access (port 22).
- Using CloudFormation:
  o Deploy EC2 Instance with YAML-based configuration.
  o Attach necessary networking components (IGW, Route Tables).
  o Output EC2 Public IP as part of the CloudFormation outputs.

3. RDS Instance Deployment

- Using Terraform:
  o Create a MySQL RDS Database with db.t3.micro instance type.
  o Define database name, username, password via input variables.
  o Deploy into a dedicated DB Subnet Group.
- Using CloudFormation:
  o Deploy RDS instance using YAML templates.
  o Ensure public access is enabled (for this project only).
  o Configure security groups to allow MySQL traLic on port 3306.

4. Dynamic Configuration
   o Avoid hardcoding all values.
   o Use variables files (variables.tf, .tfvars) and CloudFormation Parameters where
   applicable.
5. Backend/State Management
   o Store Terraform state file locally on your laptop.
   o Use AWS CLI or AWS Console for CloudFormation stack deployment.
6. GitHub Repository
   • Push your Terraform code and CloudFormation YAML files to a GitHub repository.
   • Your repository must include:
   o main.tf (Terraform configuration) o variables.tf
   (Variables definition)
   o terraform.tfvars (Variables values; sensitive data should not be pushed to GitHub)
   o backend.tf (Backend configuration)
   o CloudFormation YAML files for S3, EC2, and RDS.
   o README.md (Documentation)
   • Share your GitHub repository URL along with the submission document.
7. Presentation/Demo
   • Prepare a 5-10 minute presentation explaining:
   o Your code structure and implementation.
   o The AWS infrastructure you created.
   o Key features or challenges you encountered.
   o How your Terraform code and CloudFormation ensures modularity and best
   practices.
   • Live Demo:
   o Run your Terraform configuration (terraform init, terraform plan, terraform
   apply).
   o Create and run CloudFormation Stack using YAML’s.
   o Show the resources created in the AWS Management Console (e.g., the S3
   bucket, EC2 instance, VPC, RDS, etc.).
   o Demonstrate the use of your tfvars file, YAML and backend configuration.
   Submission Details • Submission Items: One document
   containing below items
8. GitHub repository link.
9. Screenshot(s) showing:
   • S3 Buckets created and versioning enabled.
   • EC2 Instances launched with Public IP.
   • RDS Instances running.
   • Terraform and CloudFormation code snippets.
   • Terraform apply or CloudFormation deployment outputs.
10. Terraform Files:
    § main.tf, provider.tf, variables.tf, vars.tfvars
11. CloudFormation Templates:
    § YAML files for S3, EC2, and RDS.
12. Clear and concise documentation in the README.md (in GitHub repo)
13. Power Point Presentation(PPT) slides for demo.
    Assessment Criteria (Total: 30 points)
    Weightage in Final grade: 35%
14. Functionality (10 points)
    o Are all resources deployed correctly?
15. Best Practices (5 points)
    o Use of variables and tfvars files.
    o Proper backend configuration.
    o Dynamic configuration, clean code.
16. Documentation (5 points)
    o Is the README.md clear and comprehensive?
    o Can a third party replicate the setup using your documentation?
    o Are comments added in the code?
17. Presentation/Demo (10 points)
    o Was the presentation well-structured and informative?
    o Did the demo showcase the infrastructure and code eLectively?
    o Were challenges and solutions explained clearly during presentation in
    the class?
    o Was the presentation well-structured and informative?
    Resources
    • Terraform Documentation: https://registry.terraform.io/
    • AWS Free Tier: https://aws.amazon.com/free/
    • GitHub Guides: https://guides.github.com/
