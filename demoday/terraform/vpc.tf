resource "aws_vpc" "vpc-bc-devops" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "vpc-bc-devops"
  }
}

# Publica

resource "aws_subnet" "subnet-public-us-east-1a" {
  vpc_id            = aws_vpc.vpc-bc-devops.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    "Name" = "subnet-public-us-east-1a"
  }
}

resource "aws_subnet" "subnet-public-us-east-1b" {
  vpc_id            = aws_vpc.vpc-bc-devops.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.3.0/24"
  tags = {
    "Name" = "subnet-public-us-east-1b"
  }
}

# Privada

resource "aws_subnet" "subnet-private-us-east-1a" {
  vpc_id            = aws_vpc.vpc-bc-devops.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.2.0/24"
  tags = {
    "Name" = "subnet-private-us-east-1a"
  }
}

resource "aws_subnet" "subnet-private-us-east-1b" {
  vpc_id            = aws_vpc.vpc-bc-devops.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.4.0/24"
  tags = {
    "Name" = "subnet-private-us-east-1b"
  }
}

# IGW

resource "aws_internet_gateway" "igw-bc-devops" {
  vpc_id = aws_vpc.vpc-bc-devops.id
  tags = {
    Name = "igw-bc-devops"
  }
}

# Elastic IP

resource "aws_eip" "elastic-nat-gw-us-east-1a-bc-devops" {
  domain = "vpc"
}

resource "aws_eip" "elastic-nat-gw-us-east-1b-bc-devops" {
  domain = "vpc"
}

# RTB

resource "aws_route_table" "rtb-public-bc-devops" {
  vpc_id = aws_vpc.vpc-bc-devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-bc-devops.id
  }

  tags = {
    Name = "rtb-public-bc-devops"
  }
}

resource "aws_route_table" "rtb-private-us-east-1a-bc-devops" {
  vpc_id = aws_vpc.vpc-bc-devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-us-east-1a-bc-devops.id
  }

  tags = {
    Name = "rtb-private-us-east-1a-bc-devops"
  }
}

resource "aws_route_table" "rtb-private-us-east-1b-bc-devops" {
  vpc_id = aws_vpc.vpc-bc-devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw-us-east-1b-bc-devops.id
  }

  tags = {
    Name = "rtb-private-us-east-1b-bc-devops"
  }
}

resource "aws_route_table_association" "public-1a-route-asssociation" {
  subnet_id      = aws_subnet.subnet-public-us-east-1a.id
  route_table_id = aws_route_table.rtb-public-bc-devops.id
}

resource "aws_route_table_association" "public-1b-route-asssociation" {
  subnet_id      = aws_subnet.subnet-public-us-east-1b.id
  route_table_id = aws_route_table.rtb-public-bc-devops.id
}

resource "aws_route_table_association" "private-1a-route-asssociation" {
  subnet_id      = aws_subnet.subnet-private-us-east-1a.id
  route_table_id = aws_route_table.rtb-private-us-east-1a-bc-devops.id
}

resource "aws_route_table_association" "private-1b-route-asssociation" {
  subnet_id      = aws_subnet.subnet-private-us-east-1b.id
  route_table_id = aws_route_table.rtb-private-us-east-1b-bc-devops.id
}
