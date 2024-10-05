output "aws_vpc" {
  value = aws_vpc.my_vpc
}
output "public_subnet" {
  value = aws_subnet.public_subnet
}
output "private_subnet" {
  value = aws_subnet.private_subnet
}
output "igw" {
  value = aws_internet_gateway.my_igw
}
