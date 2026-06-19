resource "aws_lb_target_group" "app_tg" {


  name     = "app-target-group"
  port     = 3000
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    interval = 30
  }
}

## --- ALB ---
resource "aws_lb" "app_alb" {

  name = "app-alb"

  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_az1.id,
    aws_subnet.public_az2.id
  ]
}

## --- Listener ---
resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.app_alb.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
