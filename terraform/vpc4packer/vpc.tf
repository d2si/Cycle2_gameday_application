provider "aws" {
  region                  = var.aws_region
  profile                 = "ice${var.team_number}"
  shared_credentials_file = "../credentials"
  version                 = "~> 2.0"
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name        = "${var.application}${var.team_number}"
    Application = var.application
    Owner       = var.owner
  }
}

data "aws_availability_zones" "available" {
}

# Public Subnet/stuff
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = "true"
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_bits, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "${var.application}${var.team_number}_PUB_1}"
    Application = var.application
    Owner       = var.owner
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}${var.team_number}_IGW"
    Application = var.application
    Owner       = var.owner
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "${var.application}${var.team_number}_PUB_RIB"
    Application = var.application
    Owner       = var.owner
  }
}

resource "aws_route_table_association" "rtap" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = element(aws_subnet.public.*.id, 0)
  route_table_id = aws_route_table.public.id
}
