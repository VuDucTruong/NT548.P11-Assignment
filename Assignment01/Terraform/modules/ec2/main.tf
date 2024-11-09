
# Create an IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach a policy to the IAM Role (for example, read-only access to S3)
resource "aws_iam_role_policy_attachment" "ec2_role_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" # Example policy
}

# Create an Instance Profile to attach the IAM Role to the EC2 instance
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}



# Tạo Public EC2 Instance
resource "aws_instance" "public_instance" {
  ami                         = var.ami_id # Thay thế bằng AMI ID thực tế
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = false
  security_groups             = [aws_security_group.public_ec2_sg.id] # Sử dụng vpc_security_group_ids thay vì security_groups
  ebs_optimized               = true
  monitoring                  = true
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
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
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
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
