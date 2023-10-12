provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-01c647eace872fc02"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.mysg.name ]
}

variable "ingressrules" {
  type = list(number)
  default = [ 80, 443 ]
}

variable "egressrules" {
  type = list(number)
  default = [ 80, 443, 25, 3306, 53, 8080 ]
}


resource "aws_security_group" "mysg" {
    name = "mysg"

    dynamic "ingress" {
      iterator = port
      for_each = var.ingressrules

      content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
      }
    }

    dynamic "egress" {
        iterator = port
        for_each = var.egressrules

        content {
            from_port = port.value
            to_port = port.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}