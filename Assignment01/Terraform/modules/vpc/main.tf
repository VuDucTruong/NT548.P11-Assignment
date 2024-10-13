# 1. Tạo VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}

# Tạo Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Tạo Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Tạo Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-subnet"
  }
}


# Tạo default security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.my_vpc.id # ID của VPC bạn muốn áp dụng

  ingress {
    protocol    = "-1" # Cho phép tất cả các protocol
    from_port   = 0    # Cho phép từ port 0 đến 65535
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"] # Cho phép truy cập từ mọi IP
  }

  egress {
    protocol    = "-1" # Cho phép tất cả các protocol
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"] # Cho phép lưu lượng truy cập đi ra mọi IP
  }

  tags = {
    Name = "Default security group"
  }
}

