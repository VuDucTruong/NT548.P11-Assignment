# Tạo Public EC2 Instance
resource "aws_instance" "public_instance" {
  ami                         = var.ami_id # Thay thế bằng AMI ID thực tế
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.public_ec2_sg_id] # Sử dụng vpc_security_group_ids thay vì security_groups
  ebs_optimized               = true
  monitoring                  = true
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
  ami                    = var.ami_id # Thay thế bằng AMI ID thực tế
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_ec2_sg_id] # Sử dụng vpc_security_group_ids thay vì security_groups
  ebs_optimized          = true
  monitoring             = true
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
