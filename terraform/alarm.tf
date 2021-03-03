resource "aws_cloudwatch_metric_alarm" "cpu" {
  count  = var.worker_count
  alarm_name                = "web-cpu-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions             = [ aws_sns_topic.alarm.arn ]

  dimensions = {
    InstanceId = aws_instance.worker[count.index].id
  }
}
