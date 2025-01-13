terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "EC2" {
    ami = "ami-003f5a76758516d1e"
    instance_type = "t2.micro"
}
