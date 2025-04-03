output "IP-EC2" {
  value = aws_instance.ec2-bc-devops.public_ip
}