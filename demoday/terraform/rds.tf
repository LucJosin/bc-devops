resource "random_password" "wordpress_db_password" {
  length  = 20
  special = true
}

resource "aws_db_instance" "rds-mysql-bc-devops" {
  apply_immediately      = true
  db_subnet_group_name   = aws_db_subnet_group.sbg-rds-bc-devops.id
  identifier             = "rds-mysql-bc-devops"
  allocated_storage      = 20
  db_name                = "wordpress"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  username               = "wordpress"
  password               = random_password.wordpress_db_password.result
  vpc_security_group_ids = [aws_security_group.sgr-rds-us-east-1-bc-devops.id]
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "sbg-rds-bc-devops" {
  name       = "sbg-rds-bc-devops"
  subnet_ids = [aws_subnet.subnet-private-us-east-1a.id, aws_subnet.subnet-private-us-east-1b.id]
  tags = {
    Name = "sbg-rds-bc-devops"
  }
}
