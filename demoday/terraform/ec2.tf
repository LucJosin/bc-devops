data "template_file" "userdata-wordpress-lt-bc-devops" {
  template = file("./script.sh")
  vars = {
    EFS_ID                = "${aws_efs_file_system.efs-bc-devops.id}.efs.${var.aws_region}.amazonaws.com"
    WORDPRESS_DB_HOST     = aws_db_instance.rds-mysql-bc-devops.address
    WORDPRESS_DB_USER     = aws_db_instance.rds-mysql-bc-devops.username
    WORDPRESS_DB_PASSWORD = aws_db_instance.rds-mysql-bc-devops.password
    WORDPRESS_DB_NAME     = aws_db_instance.rds-mysql-bc-devops.db_name
  }
}

# Launch Template
resource "aws_launch_template" "wordpress-lt-bc-devops" {
  image_id               = "ami-084568db4383264d4" # Ubuntu
  instance_type          = "t2.micro"
  user_data              = base64encode(data.template_file.userdata-wordpress-lt-bc-devops.rendered)
  vpc_security_group_ids = [aws_security_group.sgr-ec2-us-east-1-bc-devops.id]

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.ec2_tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.ec2_tags
  }
}
