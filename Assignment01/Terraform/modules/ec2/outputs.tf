output "public_ec2_id" {
  value = aws_instance.public_instance.id
}

output "private_ec2_id" {
  value = aws_instance.private_instance.id
}
