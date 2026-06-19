resource "aws_autoscaling_group" "app_asg" {

  name = "app-asg"

  desired_capacity = 2

  min_size = 2

  max_size = 4

  vpc_zone_identifier = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]

  target_group_arns = [
    aws_lb_target_group.app_tg.arn
  ]

  launch_template {

    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  health_check_type = "ELB"
}
