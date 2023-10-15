locals {
  metric_names = toset([
    "CPUUtilization",
    "DiskReadOps",
    "NetworkOut"
  ])
}

resource "aws_cloudwatch_metric_alarm" "metric_alarms" {
  for_each = local.metric_names

  alarm_name = "${each.key}_alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods = var.evaluation_periods
  metric_name = "${each.key}"
  namespace = var.namespace
  period = var.period
  statistic = var.statistic
  threshold = var.threshold
  alarm_description = "EC2 ${each.key} metric alarm"
}

output "alarms_out" {
  value = [
    for v in aws_cloudwatch_metric_alarm.metric_alarms : v.alarm_name
  ]  
}