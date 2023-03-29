module "vpc_one" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.1"

  name               = "vpc-${local.name_suffix}-1"
  cidr               = var.vpc_cidr1
  enable_nat_gateway = false
  single_nat_gateway = true

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = var.pub_subnets
  private_subnets = var.priv_subnets
  

}

# module "otra_vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 3.1"

#   name               = "vpc-${local.name_suffix}-2"
#   cidr               = "192.168.0.0/16"
#   enable_nat_gateway = false
#   single_nat_gateway = true

#   azs             = ["${var.region}a", "${var.region}b","${var.region}c"]
#   public_subnets  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]  

# }






