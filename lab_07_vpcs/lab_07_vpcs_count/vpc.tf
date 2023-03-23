
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "vpc-${local.name_suffix}" }
}

resource "aws_subnet" "public_subnet" {
  count                = length(var.public_subnets)
  map_public_ip_on_launch = true
  availability_zone_id = local.az_id[count.index]
  vpc_id               = aws_vpc.vpc1.id
  cidr_block           = var.public_subnets[count.index]
  tags                 = { "tier" = "public", "Name" = "public-${local.name_suffix}-${count.index}" }

}

resource "aws_subnet" "private_subnet" {
  count                = length(var.private_subnets)
  availability_zone_id = local.az_id[count.index]
  vpc_id               = aws_vpc.vpc1.id
  cidr_block           = var.private_subnets[count.index]

  tags =  { "tier" = "private", "Name" = "private-${local.name_suffix}-${count.index}" }
}

resource "aws_subnet" "db_subnet" {
  count                = length(var.db_subnets)
  availability_zone_id = local.az_id[count.index]
  vpc_id               = aws_vpc.vpc1.id
  cidr_block           = var.db_subnets[count.index]

  tags =  { "tier" = "database", "Name" = "database-${local.name_suffix}-${count.index}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags =  { "Name" = "igw-${local.name_suffix}" }
}

resource "aws_eip" "nat_ip" {
  count      = length(var.public_subnets)
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags       = { "Name" = "eip-${count.index}" }
}

resource "aws_nat_gateway" "natgw" {
  count         = length(var.public_subnets) 
  allocation_id = aws_eip.nat_ip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags          =  { "Name" = "natgw-${local.name_suffix}-${count.index}" }

}

resource "aws_route_table" "public_subnet_rt" {
  count  = length(var.public_subnets)
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { "Name" = "public-${local.name_suffix}-${count.index}" }
}

resource "aws_route_table_association" "pub" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_rt[count.index].id
}

resource "aws_route_table" "private_subnet_rt" {
  count  = length(var.private_subnets)
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw[count.index].id
  }
  tags = { "Name" = "private-${local.name_suffix}-${count.index}" }
}


resource "aws_route_table_association" "priv" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_rt[count.index].id
}

resource "aws_route_table" "db_subnet_rt" {
  count  = length(var.db_subnets)
  vpc_id = aws_vpc.vpc1.id
  tags   = { "Name" = "database-${count.index}" }
}

resource "aws_route_table_association" "db" {
  count = length(var.db_subnets)

  subnet_id      = aws_subnet.db_subnet[count.index].id
  route_table_id = aws_route_table.db_subnet_rt[count.index].id
}



resource "aws_security_group" "sec_web" {
  vpc_id = aws_vpc.vpc1.id
  name   = "sec-web-lab7"
  ingress {
    description = "SSH from specific addresses"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }
  ingress {
    description = "Ping from specific addresses"
    from_port   = 8 # ICMP Code 8 - echo  (0 is echo reply)
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.sec_allowed_external
  }

  ingress {
    description = "TCP Port 80 from specific addresses"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sec-web-lab7"
  }

}


resource "aws_security_group" "sec_back" {
  vpc_id = aws_vpc.vpc1.id
  name   = "sec-back-lab7"
  ingress {
    description = "SSH from specific addresses"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }
  ingress {
    description = "Ping from specific addresses"
    from_port   = 8 # ICMP Code 8 - echo  (0 is echo reply)
    to_port     = 0
    protocol    = "icmp"
    security_groups = [aws_security_group.sec_web.id]
  }

  ingress {
    description = "TCP Port 80 from specific addresses"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = var.sec_allowed_external
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sec-back-lab7"
  }

}

