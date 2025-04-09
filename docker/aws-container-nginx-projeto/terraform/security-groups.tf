#Configuração do security group para acesso ssh e http
resource "aws_security_group" "sgr-public-bc-devops" {
  name        = "sgr-public-bc-devops"
  description = "Allow incoming HTTP and SSH connections."
  vpc_id      = aws_vpc.vpc-bc-devops.id

  #Inbound
  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgr-public-bc-devops"
  }
}
