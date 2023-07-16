output "public_ec2_1" {
  value = aws_instance.public_1.id
}

output "public_ec2_2" {
  value = aws_instance.public_2.id
}

output "private_ec2_1" {
  value = aws_instance.private_1.id
}

output "private_ec2_2" {
  value = aws_instance.private_2.id
}

