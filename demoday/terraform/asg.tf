resource "aws_autoscaling_group" "asg-bc-devops" {
  name                      = "asg-bc-devops"
  max_size                  = 3
  min_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.subnet-private-us-east-1a.id, aws_subnet.subnet-private-us-east-1b.id]
  health_check_type         = "EC2"
  force_delete              = true
  wait_for_capacity_timeout = "0"
  target_group_arns         = [aws_alb_target_group.tg-bc-devops.arn]

  launch_template {
    id      = aws_launch_template.wordpress-lt-bc-devops.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-bc-devops"
    propagate_at_launch = false
  }

  lifecycle {
    create_before_destroy = true
  }
}
