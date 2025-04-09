resource "aws_vpc" "vpc-bc-devops" {
  cidr_block           = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-bc-devops"
  }
}

resource "aws_subnet" "subnet-public-us-east-1a" {
  vpc_id            = aws_vpc.vpc-bc-devops.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    "Name" = "subnet-public-us-east-1a"
  }
}

resource "aws_internet_gateway" "igw-bc-devops" {
  vpc_id = aws_vpc.vpc-bc-devops.id
  tags = {
    Name = "igw-bc-devops"
  }
}

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

resource "aws_route_table_association" "public-1a-route-asssociation" {
  subnet_id      = aws_subnet.subnet-public-us-east-1a.id
  route_table_id = aws_route_table.rtb-public-bc-devops.id
}