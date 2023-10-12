provider "aws" {
  region = "us-east-1"
}

resource "aws_sns_topic" "alarm" {
  name = "high-cpu-topic"
}

resource "aws_cloudwatch_composite_alarm" "ec2_alarm" {
  alarm_description = var.alarm_description
  alarm_name = var.alarm_name

  alarm_actions = [aws_sns_topic.alarm.arn]
  ok_actions = [aws_sns_topic.alarm.arn]

  alarm_rule = "(ALARM(${module.alarm_module.alarms_out[0]}) OR ALARM(${module.alarm_module.alarms_out[1]})) AND OK(${module.alarm_module.alarms_out[2]})"

  depends_on = [
    module.alarm_module,
    aws_sns_topic.alarm
  ]
}

module "alarm_module" {
  source = "./alarms"
}

output "sns_out" {
  value = [module.alarm_module.alarms_out , aws_sns_topic.alarm.arn]
}
