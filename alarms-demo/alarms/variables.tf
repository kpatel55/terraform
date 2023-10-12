variable "comparison_operator" {
  type = string
  default = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  type = number
  default = 3
}

variable "namespace" {
  type = string
  default = "AWS/EC2"
}

variable "period" {
  type = number
  default = 180
}

variable "statistic" {
  type = string
  default = "Average"
}

variable "threshold" {
  type = number
  default = 75
}