resource "aws_efs_file_system" "efs-bc-devops" {
  encrypted = true
  tags = {
    Name = "efs-bc-devops"
  }
}

resource "aws_efs_mount_target" "subnet-us-east-1a-private-bc-devops" {
  file_system_id  = aws_efs_file_system.efs-bc-devops.id
  subnet_id       = aws_subnet.subnet-private-us-east-1a.id
  security_groups = [aws_security_group.sgr-efs-us-east-1-bc-devops.id]
}

resource "aws_efs_mount_target" "subnet-us-east-1b-private-bc-devops" {
  file_system_id  = aws_efs_file_system.efs-bc-devops.id
  subnet_id       = aws_subnet.subnet-private-us-east-1b.id
  security_groups = [aws_security_group.sgr-efs-us-east-1-bc-devops.id]
}
