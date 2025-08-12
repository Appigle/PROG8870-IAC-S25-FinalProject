# Outputs
# This file defines the outputs that will be displayed after Terraform applies

# S3 Bucket Information
output "s3_bucket_names" {
  description = "Names of the created S3 buckets"
  value       = aws_s3_bucket.ray_buckets[*].bucket
}

output "s3_bucket_arns" {
  description = "ARNs of the created S3 buckets"
  value       = aws_s3_bucket.ray_buckets[*].arn
}

# VPC Information
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.ray_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.ray_vpc.cidr_block
}

# Subnet Information
output "public_subnet_1_id" {
  description = "ID of the first public subnet"
  value       = aws_subnet.ray_public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "ID of the second public subnet"
  value       = aws_subnet.ray_public_subnet_2.id
}

output "public_subnet_1_cidr" {
  description = "CIDR block of the first public subnet"
  value       = aws_subnet.ray_public_subnet_1.cidr_block
}

output "public_subnet_2_cidr" {
  description = "CIDR block of the second public subnet"
  value       = aws_subnet.ray_public_subnet_2.cidr_block
}

# EC2 Instance Information
output "ec2_instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.ray_ec2.id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ray_ec2.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.ray_ec2.public_dns
}

output "ec2_ami_id" {
  description = "AMI ID used for the EC2 instance"
  value       = data.aws_ami.ray_ami.id
}

# Security Group Information
output "ec2_security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ray_ec2_sg.id
}

# Internet Gateway Information
output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.ray_igw.id
}

# Route Table Information
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.ray_public_rt.id
} 