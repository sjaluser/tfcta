## NOTE:  we call this file "root-main" for illustration purposes only. 
##     to help students distinguish it from the main.tf file in modules


module "vpc_proj2" {
  #  source            = "../modules/aws-web-vpc"
  source            = "github.com/rpgd60/tfcourse-modules//web-modules/aws-web-vpc"
  vpc_name          = var.project
  subnet_name       = "${var.project}-subnet"
  aws_az            = "${var.region}c"
  vpc_cidr_block    = var.vpc_cidr
  subnet_cidr_block = var.subnet_cidr
}

