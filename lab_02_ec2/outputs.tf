

## To use for example in IAM policies or retrieving caller identity
data "aws_caller_identity" "current" {

}
output "user_identity" {
  description = "Info about IAM principal used by Terraform to configure AWS"
  value       = data.aws_caller_identity.current
}


output "public_ip_prueba1" {
    value = aws_instance.prueba1.public_dns
}
output "public_ip_prueba2" {
    value = aws_instance.prueba2.public_dns
}