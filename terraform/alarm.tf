data "aws_sns_topic" "example" {
  name = "test-poc"
  depends_on = [
      aws_cloudformation_stack.tf_sns_topic
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  count  = var.worker_count
  //count = length(data.aws_instances.worker.ids)
  alarm_name                = "web-cpu-alarm${count.index}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions             = [ data.aws_sns_topic.example.arn ]

  dimensions = {
    //InstanceId = each.key
    InstanceId = aws_instance.worker[count.index].id
  }
  depends_on = [
      aws_instance.worker
  ]
}
