output "public_ec2_id" {
  value = aws_instance.public_instance.id
}

output "private_ec2_id" {
  value = aws_instance.private_instance.id
}
output "private_ec2_sg_id" {
  value = aws_security_group.private_ec2_sg.id
}
output "public_ec2_sg_id" {
  value = aws_security_group.public_ec2_sg.id
}
