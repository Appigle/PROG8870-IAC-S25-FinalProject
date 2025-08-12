# EC2 Instance AMI Data Source
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "ray_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 Instance
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