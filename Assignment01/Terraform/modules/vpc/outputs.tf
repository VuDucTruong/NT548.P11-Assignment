output "aws_vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "igw_id" {
  value = aws_internet_gateway.my_igw.id
}
output "default_security_group_id" {
  value = aws_default_security_group.default.id
}
