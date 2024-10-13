
# Tạo Elastic IP cho NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Tạo NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "my-nat-gateway"
  }
}
