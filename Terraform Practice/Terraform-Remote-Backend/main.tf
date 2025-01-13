terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }

backend "s3" {
        bucket = "my-test-bucket-68aa47adfb67d01b"
        key = "remote-backend.tfstate"
        region = "ap-southeast-2"
    }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "test_server" {
    ami = "ami-0d6560f3176dc9ec0"
    instance_type = "t2.micro"
    tags = {
      key = "test-server"
    }
}
