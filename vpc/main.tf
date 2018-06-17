provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "vpc_az" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "terraform-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "terraform-igw"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.vpc_az.names[0]}"
  cidr_block        = "${var.subnet_private_cidr}"

  tags {
    Name = "PrivateSubnetAZA-TF"
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = "${aws_vpc.main.id}"
  availability_zone       = "${data.aws_availability_zones.vpc_az.names[1]}"
  cidr_block              = "${var.subnet_public_cidr}"
  map_public_ip_on_launch = true

  tags {
    Name = "PublicSubnetAZB-TF"
  }
}

resource "aws_route_table" "routetable_public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "RouteTable-Public-TF"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table" "routetable_private" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "RouteTable-Private-TF"
  }
}
