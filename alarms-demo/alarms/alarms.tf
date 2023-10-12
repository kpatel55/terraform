resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name = "high_cpu_alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods = var.evaluation_periods
  metric_name = "CPUUtilization"
  namespace = var.namespace
  period = var.period
  statistic = var.statistic
  threshold = var.threshold
  alarm_description = "EC2 high CPU utilization metric alarm"
}

resource "aws_cloudwatch_metric_alarm" "high_disk_read" {
  alarm_name = "high_disk_read_alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods = var.evaluation_periods
  metric_name = "DiskReadOps"
  namespace = var.namespace
  period = var.period
  statistic = var.statistic
  threshold = var.threshold
  alarm_description = "EC2 high disk read metric alarm"
}

resource "aws_cloudwatch_metric_alarm" "high_net_out" {
  alarm_name = "high_net_out_alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods = var.evaluation_periods
  metric_name = "NetworkOut"
  namespace = var.namespace
  period = var.period
  statistic = var.statistic
  threshold = var.threshold
  alarm_description = "EC2 high network-out metric alarm"
}

output "alarms_out" {
  value = [
    aws_cloudwatch_metric_alarm.high_cpu.alarm_name,
    aws_cloudwatch_metric_alarm.high_net_out.alarm_name,
    aws_cloudwatch_metric_alarm.high_disk_read.alarm_name
  ]
}