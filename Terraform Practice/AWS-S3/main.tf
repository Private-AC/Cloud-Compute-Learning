terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }

    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "random_id" "random_s3" {
  byte_length = 8
}

resource "aws_s3_bucket" "test-bucket" {
    bucket = "my-test-bucket-${random_id.random_s3.hex}"    
}

resource "aws_s3_object" "data-upload" {
  bucket = aws_s3_bucket.test-bucket.bucket
  source = "./test.txt"
  key = "testfile.txt"
}

output "testing_randomid" {
  value = random_id.random_s3.hex
}