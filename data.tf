data "aws_ami" "rohithdevops" {
  owners = ["973714476881"]
  most_recent = true
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default" {
    default = true
}