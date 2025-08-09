# S3 Buckets
resource "aws_s3_bucket" "ray_buckets" {
  count  = 4
  bucket = "${var.ray_project_name}-bucket-${count.index + 1}-${var.ray_environment}"
}

resource "aws_s3_bucket_versioning" "ray_bucket_versioning" {
  count  = 4
  bucket = aws_s3_bucket.ray_buckets[count.index].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "ray_bucket_public_access_block" {
  count  = 4
  bucket = aws_s3_bucket.ray_buckets[count.index].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# VPC
resource "aws_vpc" "ray_vpc" {
  cidr_block           = var.ray_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.ray_project_name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "ray_igw" {
  vpc_id = aws_vpc.ray_vpc.id

  tags = {
    Name = "${var.ray_project_name}-igw"
  }
}

# Public Subnet 1
resource "aws_subnet" "ray_public_subnet_1" {
  vpc_id                  = aws_vpc.ray_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ray_project_name}-public-subnet-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "ray_public_subnet_2" {
  vpc_id                  = aws_vpc.ray_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ray_project_name}-public-subnet-2"
  }
}

# Route Table
resource "aws_route_table" "ray_public_rt" {
  vpc_id = aws_vpc.ray_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ray_igw.id
  }

  tags = {
    Name = "${var.ray_project_name}-public-rt"
  }
}

resource "aws_route_table_association" "ray_public_rta_1" {
  subnet_id      = aws_subnet.ray_public_subnet_1.id
  route_table_id = aws_route_table.ray_public_rt.id
}

resource "aws_route_table_association" "ray_public_rta_2" {
  subnet_id      = aws_subnet.ray_public_subnet_2.id
  route_table_id = aws_route_table.ray_public_rt.id
}

# Security Group for EC2
resource "aws_security_group" "ray_ec2_sg" {
  name_prefix = "${var.ray_project_name}-ec2-sg"
  vpc_id      = aws_vpc.ray_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ray_project_name}-ec2-sg"
  }
}

# EC2 Instance  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "ray_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ray_ec2" {
  ami                         = data.aws_ami.ray_ami.id
  instance_type               = var.ray_instance_type
  subnet_id                   = aws_subnet.ray_public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.ray_ec2_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.ray_project_name}-ec2"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "ray_db_subnet_group" {
  name       = "${var.ray_project_name}-db-subnet-group"
  subnet_ids = [aws_subnet.ray_public_subnet_1.id, aws_subnet.ray_public_subnet_2.id]

  tags = {
    Name = "${var.ray_project_name}-db-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "ray_rds_sg" {
  name_prefix = "${var.ray_project_name}-rds-sg"
  vpc_id      = aws_vpc.ray_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ray_ec2_sg.id]
  }

  tags = {
    Name = "${var.ray_project_name}-rds-sg"
  }
}

# RDS Instance
resource "aws_db_instance" "ray_rds" {
  identifier           = "${var.ray_project_name}-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = var.ray_db_name
  username             = var.ray_db_username
  password             = var.ray_db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true

  vpc_security_group_ids = [aws_security_group.ray_rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.ray_db_subnet_group.name

  tags = {
    Name = "${var.ray_project_name}-rds"
  }
} 