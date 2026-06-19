resource "aws_sns_topic" "alerts" {

  name = "project-alerts"
}

## --- Email Subscription ---
resource "aws_sns_topic_subscription" "email_alert" {

  topic_arn = aws_sns_topic.alerts.arn

  protocol = "email"

  endpoint = "aashishthakur14609@gmail.com"
}

## --- CloudWatch Alarm --- 
resource "aws_cloudwatch_metric_alarm" "high_cpu" {

  alarm_name = "HighCPUAlarm"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 120

  statistic = "Average"

  threshold = 70

  alarm_description = "CPU exceeds 70%"

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_asg.name
  }
}
