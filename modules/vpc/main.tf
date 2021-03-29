resource "aws_vpc" "main" {

  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = var.tags
}

resource "aws_subnet" "private" {
  count                   = length(var.private_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

### PRIVATE ROUTE TABLE ###

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  depends_on = [aws_nat_gateway.nat]
}

resource "aws_route_table_association" "private_assoc" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

### PRIVATE ROUTE TABLE ###


### PUBLIC ROUTE TABLE ###

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

### PUBLIC ROUTE TABLE ###


### IGW ###
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
### IGW ###


### EIP ###
resource "aws_eip" "nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}
### EIP ###


### NAT GATEWAY ###
resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "default nat gateway"
  }

  depends_on = [aws_eip.nat]
}