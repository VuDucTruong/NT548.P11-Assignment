
# Tạo Route Table cho Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Gắn Route Table vào Public Subnet
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public_route_table.id
}

# Tạo Route Table cho Private Subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Gắn Route Table vào Private Subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private_route_table.id
}
