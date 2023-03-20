## AWS Specific parameters

variable "region" {
  type    = string
  default = "eu-west-1"
}


## Region 2 eg for disaster recovery
variable "region2" {
  type    = string
  # default = "eu-south-2"
  default = "eu-central-1"
}

variable "profile" {
  type    = string
  default = "cta"
}


## Environment and Project
variable "lab_number" {
  type        = string
  description = "lab number"
  default     = "ex1"
}

variable "environment" {
  type        = string
  description = "e.g. test dev prod"
  default     = "dev"
}

variable "project" {
  type    = string
  default = "proj99"
}

## VPC parameters
variable "vpc_cidr" {
  type    = string
  default = "10.99.0.0/16"
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr)) ## Needs work
    error_message = "Invalid CIDR for VPC."
  }
}

## EC2 Instance Parameters

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "my_ami" {
  description = "ami for EC2 instance"
  type        = string
  default     = "ami-0b752bf1df193a6c4"
}


variable "company" {
  type        = string
  description = "company name - will be used in tags"
  default     = "acme"
}

## Security Groups
variable "sec_allowed_external" {
  description = "CIDRs from which access is allowed"
  type        = list(string)
  default     = ["0.0.0.0/0"]
  # default = ["2.37.1.5/32"]
}



## specific for "count"
variable "num_instances" {
  type    = number
  default = 2
}

variable "num_azs" {
  type        = number
  description = "Number of AZs to distribute instances"
  validation {
    condition     = var.num_azs >= 1 && var.num_azs <= 3
    error_message = "Invalid number of AZs to distribute instances"
  }
}