output "vpc_id" {
  description = "ID of the vpc"
  value       = module.basic_vpc.vpc_id
}

output "subnet_id" {
  description = "ID of the vpc"
  value       = module.basic_vpc.subnet_id
}

output "subnet_cidr" {
  description = "CIDR of subnet"
  value       = module.basic_vpc.subnet_cidr
}

output "subnet_az" {
  description = "AZ of the subnet"
  value       = module.basic_vpc.subnet_az
}


output "vpc_id2" {
  description = "ID of the vpc"
  value       = module.basic_vpc2[0].vpc_id
}

output "subnet_id2" {
  description = "ID of the vpc"
  value       = module.basic_vpc2[0].subnet_id
}

output "subnet_cidr2" {
  description = "CIDR of subnet"
  value       = module.basic_vpc2[1].subnet_cidr
}

output "subnet_az2" {
  description = "AZ of the subnet"
  value       = module.basic_vpc2[1].subnet_az
}
