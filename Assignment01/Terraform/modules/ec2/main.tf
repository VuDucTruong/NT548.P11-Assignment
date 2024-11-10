
# Tạo Public EC2 Instance
resource "aws_instance" "public_instance" {
  ami                         = var.ami_id # Thay thế bằng AMI ID thực tế
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = false
  security_groups             = [aws_security_group.public_ec2_sg.id] # Sử dụng vpc_security_group_ids thay vì security_groups
  ebs_optimized               = true
  monitoring                  = true
  iam_instance_profile = "admin"
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required" # Enables only IMDSv2
  }
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "public_instance"
  }
}

# Tạo Private EC2 Instance
resource "aws_instance" "private_instance" {
  ami                  = var.ami_id # Thay thế bằng AMI ID thực tế
  instance_type        = var.instance_type
  subnet_id            = var.private_subnet_id
  security_groups      = [aws_security_group.private_ec2_sg.id] # Sử dụng vpc_security_group_ids thay vì security_groups
  ebs_optimized        = true
  monitoring           = true
  iam_instance_profile = "admin"
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required" # Enables only IMDSv2
  }
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "private_instance"
  }
}


# Tạo Security Group cho Public EC2 Instance (chỉ cho phép SSH từ IP cụ thể)
resource "aws_security_group" "public_ec2_sg" {
  vpc_id      = var.vpc_id
  description = "public security group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.device_ip}/32"]
    description = "Allow SSH from my IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "public-ec2-sg"
  }
}

# Tạo Security Group cho Private EC2 Instance (chỉ cho phép SSH từ Public EC2)
resource "aws_security_group" "private_ec2_sg" {
  vpc_id      = var.vpc_id
  description = "private security group"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2_sg.id] # Chỉ cho phép từ Public EC2 SG
    description     = "Allow SSH from my public group"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "private-ec2-sg"
  }
}
