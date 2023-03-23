

## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "public_servers" {
  count         = var.num_instances
  ami           = var.my_ami
  instance_type = var.instance_type
  key_name = "test_key_pairs"
  vpc_security_group_ids = [aws_security_group.sec_web.id]

  
  ## Note use of module (aka remainder) operator 
  ## Example if var.num_azs is 3: 
  # Instance 0 -> AZ 0
  # Instance 1 -> AZ 1
  # Instance 2 -> AZ 2
  # Instance 3 -> AZ 0
  # Instance 4 -> AZ 1
  # etc.
  subnet_id = aws_subnet.public_subnet[count.index % length(var.public_subnets)].id

  tags = {
    Name = "vm-public-${local.name_suffix}-${count.index}"
  }
}



## Create instance - will use defaults for parameters not specified (e.g. VPC, security group)
resource "aws_instance" "private_servers" {
  count         = var.num_instances
  ami           = var.my_ami
  instance_type = var.instance_type
  key_name = "test_key_pairs"

   vpc_security_group_ids = [aws_security_group.sec_back.id]
  ## Note use of module (aka remainder) operator 
  ## Example if var.num_azs is 3: 
  # Instance 0 -> AZ 0
  # Instance 1 -> AZ 1
  # Instance 2 -> AZ 2
  # Instance 3 -> AZ 0
  # Instance 4 -> AZ 1
  # etc.
  subnet_id = aws_subnet.private_subnet[count.index % length(var.public_subnets)].id

  tags = {
    Name = "vm-private-${local.name_suffix}-${count.index}"
  }
}

