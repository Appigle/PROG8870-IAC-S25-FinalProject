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