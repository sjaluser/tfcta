data "aws_ami_ids" "ubuntu_amis" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

data "aws_ami_ids" "ubuntu_amis_r2" {
  provider = aws.region2
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}

## Filter based on ubuntu web article
# https://ubuntu.com/tutorials/search-and-launch-ubuntu-22-04-in-aws-using-cli

data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*22.04*amd64-server*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

data "aws_ami" "ubuntu_20_04" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*20.04*-amd64-server*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

data "aws_ami" "ubuntu_20_04_r2" {
  most_recent = true
  provider = aws.region2
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*20.04*-amd64-server*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}


## Data sources to identify the default vpc and its subnets
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "def_vpc" {
  default = true
}

## Data sources to identify the default vpc and its subnets
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "def_vpc_r2" {
  provider = aws.region2
  default = true
}

# Subnet data source
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
data "aws_subnets" "def_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.def_vpc.id]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
data "aws_subnets" "def_vpc_subnets_r2" {
  provider = aws.region2
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.def_vpc_r2.id]
  }
}