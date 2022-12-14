##VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["environment"]}-vpc"
  }
}

##Public Subnets
resource "aws_subnet" "public-subnets" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["environment"]}-public-${substr(element(var.availability_zones, count.index), -2, 2)}"
  }

}

##Private Subnets
resource "aws_subnet" "private-subnets" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["environment"]}-private-${substr(element(var.availability_zones, count.index), -2, 2)}"
  }

}

##Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["environment"]}-igw"
  }
}

##Public Route Table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["environment"]}-public-rtb"
  }

}

##Public Internet Gateway
resource "aws_route" "public-internet-gateway" {
  gateway_id             = aws_internet_gateway.internet-gateway.id
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
}

##Public Routes Association
resource "aws_route_table_association" "public-routes-association" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public-subnets.*.id, count.index)
  route_table_id = aws_route_table.public-route-table.id
}

##Private Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["environment"]}-private-rtb"
  }

}

##Private Routes Association
resource "aws_route_table_association" "private-route-table-association" {
  count       = length(var.private_subnets)
  subnet_id   = element(aws_subnet.private-subnets.*.id, count.index)
  route_table = aws_route_table.private-route-table.id
}