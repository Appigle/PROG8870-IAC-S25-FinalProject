variable "ray_aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ray_project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "ray-infrastructure"
}

variable "ray_environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "ray_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ray_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ray_db_name" {
  description = "Database name"
  type        = string
  default     = "ray_db"
}

variable "ray_db_username" {
  description = "Database username"
  type        = string
  default     = "ray"
}

variable "ray_db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
} 