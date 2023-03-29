## Environment and Project
variable "environment" {
  type        = string
  description = "e.g. test dev prod"
  default     = "dev"
}

variable "company" {
  type    = string
  default = "WayneCorp"
}
variable "project" {
  type = string
}

## AWS Specific parameters
variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "profile" {
  type = string
}

## EC2 Instance Parameters
variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

## Discuss why this variable may be a bad idea...
variable "subnet_cidr" {
  description = "CIDR for subnet"
  type        = string
}

# variable "key_name" {
#   type    = string
#   default = "tf-course"
# }

variable "lab_number" {
  type = string
}

variable "server_os" {
  description = "ubuntu or amazon_linux"
  validation {
    condition     = contains(["ubuntu", "amazon_linux"], var.server_os)
    error_message = "Valid values for os: unbuntu or amazon_linux."
  }
  default = "ubuntu"
}