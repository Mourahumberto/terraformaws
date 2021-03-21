#############
# VPC Configs
#############

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "platform-core-vpc"
  }
}

####################################
# Internet Gateway to Public Subnets
####################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "platform-core-igw"
  }

}

############################
# Elastic IP to NAT Gateways
############################

resource "aws_eip" "vpc_eip_1" {
  vpc        = true
  tags = {
    Name = "nat-a-eip"
  }
}

resource "aws_eip" "vpc_eip_2" {
  vpc        = true
  
  tags = {
    Name = "nat-b-eip"
  }
}

resource "aws_eip" "vpc_eip_3" {
  vpc        = true
  tags = {
    Name = "nat-c-eip"
  }
}

################################
# NAT Gateway to Public Subnets
################################

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.vpc_eip_1.id
  subnet_id     = aws_subnet.public_a.id


  tags = {
    Name = "nat-gateway-a"
  }
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.vpc_eip_2.id
  subnet_id     = aws_subnet.public_b.id

  tags = {
    Name = "nat-gateway-b"
  }
}

resource "aws_nat_gateway" "nat_c" {
  allocation_id = aws_eip.vpc_eip_3.id
  subnet_id     = aws_subnet.public_c.id

  tags = {
    Name = "nat-gateway-c"
  }
}

################
# Public Subnets
################

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_a_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_a

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_b_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_b

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_c_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az_c

  tags = {
    Name = "public-subnet-1c"
  }
}

#################
# Private Subnets
#################

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "private-subnet-1b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_c_cidr
  availability_zone = var.az_c

  tags = {
    Name = "private-subnet-1c"
  }
}

##############
# Data Subnets
##############

resource "aws_subnet" "data_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.data_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "data-subnet-1a"
  }
}

resource "aws_subnet" "data_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.data_b_cidr
  availability_zone = var.az_b

  tags = {
    Name = "data-subnet-1b"
  }
}

resource "aws_subnet" "data_c" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.data_c_cidr
  availability_zone = var.az_c

  tags = {
    Name = "data-subnet-1c"
  }
}

###############################
# Route Table to Public Subnets
###############################

##################################
# New feature Add main_route_table
##################################

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

###############################
# Association to Public Subnets
###############################

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_vpc.main_vpc.main_route_table_id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_vpc.main_vpc.main_route_table_id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_vpc.main_vpc.main_route_table_id
}

################################
# Route Table to Private Subnets 
################################

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "private-rt-a"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "-private-rt-b"
  }
}

resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "private-rt-c"
  }
}

####################################
# Routes from Private Subnets to NAT
####################################

resource "aws_route" "private_a" {
  route_table_id         = aws_route_table.private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_a.id
}

resource "aws_route" "private_b" {
  route_table_id         = aws_route_table.private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_b.id
}

resource "aws_route" "private_c" {
  route_table_id         = aws_route_table.private_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_c.id
}

################################
# Association to Private Subnets
################################

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

################################
# Association to Data Subnets
################################

resource "aws_route_table_association" "data_a" {
  subnet_id      = aws_subnet.data_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "data_b" {
  subnet_id      = aws_subnet.data_b.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table_association" "data_c" {
  subnet_id      = aws_subnet.data_c.id
  route_table_id = aws_route_table.private_c.id
}