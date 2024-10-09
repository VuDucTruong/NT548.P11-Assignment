output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}
output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}
output "public_rt_assocication_id" {
  value = aws_route_table_association.public_route_table_association.id
}

output "private_rt_assocication_id" {
  value = aws_route_table_association.private_route_table_association.id
}
