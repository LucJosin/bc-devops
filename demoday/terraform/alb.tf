resource "aws_lb" "alb-bc-devops" {
  name               = "alb-bc-devops"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sgr-alb-us-east-1-bc-devops.id]
  subnets            = [aws_subnet.subnet-public-us-east-1a.id, aws_subnet.subnet-public-us-east-1b.id]

  enable_deletion_protection = false

  tags = {
    Name = "alb-bc-devops"
  }
}

resource "aws_lb_listener" "tg-listener-bc-devops" {
  load_balancer_arn = aws_lb.alb-bc-devops.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg-bc-devops.arn
  }
}

resource "aws_alb_target_group" "tg-bc-devops" {
  name        = "tg-bc-devops"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  health_check {
    path     = "/wp-admin/install.php"
    protocol = "HTTP"
  }
  vpc_id = aws_vpc.vpc-bc-devops.id
}
