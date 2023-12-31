provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-01c647eace872fc02"
    instance_type = "t2.micro"

}

resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2.id
}

output "eip" {
  value = aws_eip.elasticip.public_ip
}