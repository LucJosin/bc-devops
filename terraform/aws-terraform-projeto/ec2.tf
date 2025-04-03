resource "aws_instance" "ec2-bc-devops" {
  ami                         = "ami-0a0e5d9c7acc336f1"
  instance_type               = "t2.micro"
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.sgr-public-bc-devops.id]
  user_data                   = file("script.sh")
  subnet_id                   = aws_subnet.subnet-public-us-east-1a.id
  associate_public_ip_address = true

  tags        = var.ec2_tags
  volume_tags = var.ec2_tags
}
