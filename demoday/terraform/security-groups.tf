resource "aws_security_group" "sgr-alb-us-east-1-bc-devops" {
  name        = "sgr-alb-us-east-1-bc-devops"
  description = "Security Group para Classic Load Balancer"
  vpc_id      = aws_vpc.vpc-bc-devops.id

  #Inbound
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
    Name = "sgr-alb-us-east-1-bc-devops"
  }
}

resource "aws_security_group" "sgr-ec2-us-east-1-bc-devops" {
  name        = "sgr-ec2-us-east-1-bc-devops"
  description = "Security Group para EC2"
  vpc_id      = aws_vpc.vpc-bc-devops.id

  #Inbound
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sgr-alb-us-east-1-bc-devops.id]
  }

  #Inbound
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    self      = true
  }

  #Outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sgr-ec2-us-east-1-bc-devops"
  }
}

resource "aws_security_group" "sgr-efs-us-east-1-bc-devops" {
  name        = "sgr-efs-us-east-1-bc-devops"
  description = "Security Group para EFS"
  vpc_id      = aws_vpc.vpc-bc-devops.id

  #Inbound
  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.sgr-ec2-us-east-1-bc-devops.id]
  }

  #Outbound
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.sgr-ec2-us-east-1-bc-devops.id]
  }

  tags = {
    Name = "sgr-efs-us-east-1-bc-devops"
  }
}

resource "aws_security_group" "sgr-rds-us-east-1-bc-devops" {
  name        = "sgr-rds-us-east-1-bc-devops"
  description = "Security Group para RDS"
  vpc_id      = aws_vpc.vpc-bc-devops.id

  #Inbound
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sgr-ec2-us-east-1-bc-devops.id]
  }

  tags = {
    Name = "sgr-rds-us-east-1-bc-devops"
  }
}
