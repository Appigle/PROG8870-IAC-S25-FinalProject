
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