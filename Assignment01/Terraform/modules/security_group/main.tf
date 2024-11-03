# Tạo Security Group cho Public EC2 Instance (chỉ cho phép SSH từ IP cụ thể)
resource "aws_security_group" "public_ec2_sg" {
  vpc_id = var.vpc_id

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
  vpc_id = var.vpc_id

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
