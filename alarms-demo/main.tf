provider "aws" {
  region = "us-east-1"
}

module "alarm_module" {
  source = "./alarms"
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

  # actions_suppressor {
  #   alarm            = "your_suppressor_alarm_name_goes_here"
  #   extension_period = 10
  #   wait_period      = 20
  # }

  depends_on = [
    module.alarm_module,
    aws_sns_topic.alarm
  ]
}

output "sns_out" {
  value = [module.alarm_module.alarms_out , aws_sns_topic.alarm.arn]
}
