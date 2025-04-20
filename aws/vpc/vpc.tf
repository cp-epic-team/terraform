resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project}-vpc"
  }
}

data "aws_availability_zones" "available_azs" {
  state = "available"
}

locals {
  effective_azs = min(var.desired_azs, length(data.aws_availability_zones.available_azs.names)) 
  az_list       = slice(data.aws_availability_zones.available_azs.names, 0, local.effective_azs)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_subnet" "public_subnets" {
  count = var.public_subnet_no
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 100)
  availability_zone = local.az_list[count.index % length(local.az_list)]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.project}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = var.private_subnet_no
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = local.az_list[count.index % length(local.az_list)]

  tags = {
    Name = "${var.project}-private-subnet-${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route = {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route = {
    cidr_block = "0.0.0.0"
    # aws_internet_gateway = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
    for_each = {for idx, subnet in aws_subnet.public_subnets: idx => subnet}
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = each.value.id
}

resource "aws_route_table_association" "private_route_table_association" {
  for_each = {for idx, subnet in awaws_subnet.private_subnets: idx => subnet}
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = each.value.id
}
