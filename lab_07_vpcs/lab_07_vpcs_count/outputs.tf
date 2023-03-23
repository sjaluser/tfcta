output "user_identity" {
  value       = data.aws_availability_zones.available
}

output "aws_instances_private_servers" {
  value       =   [
    for server in aws_instance.private_servers : server.public_dns
  ]
}

output "aws_instances_public_servers" {
  value =   [
    for server in aws_instance.public_servers : server.public_dns
  ]
}