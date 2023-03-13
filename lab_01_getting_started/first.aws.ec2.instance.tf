terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
      # version = "< 4.0"
    }
  }
  required_version = ">= 1.3.0"
  # required_version = "< 1.3"
}

provider "aws" {
  profile = "cta"
  region  = "eu-west-1"
}

variable "my_ami" {
  description = "ami for EC2 instance"
  type        = string
  default     = "ami-0b752bf1df193a6c4"
}


resource "aws_instance" "server1" {
  ami           = var.my_ami
  instance_type = "t2.micro"

  tags = {
    Name    = "vm1"
    project = "acme"
  }
}

