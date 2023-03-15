locals {
  ninstances = length(var.instance_names)
}

## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "server" {
  count         = local.ninstances
  ami           = var.my_ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sec_web.id]

  tags = {
    Name = "server-${var.instance_names[count.index]}"
  }
}



