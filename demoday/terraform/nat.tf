resource "aws_nat_gateway" "nat-gw-us-east-1a-bc-devops" {
  allocation_id = aws_eip.elastic-nat-gw-us-east-1a-bc-devops.id
  subnet_id     = aws_subnet.subnet-public-us-east-1a.id

  tags = {
    Name = "nat-gw-us-east-1a-bc-devops"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw-bc-devops]
}

resource "aws_nat_gateway" "nat-gw-us-east-1b-bc-devops" {
  allocation_id = aws_eip.elastic-nat-gw-us-east-1b-bc-devops.id
  subnet_id     = aws_subnet.subnet-public-us-east-1b.id

  tags = {
    Name = "nat-gw-us-east-1b-bc-devops"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw-bc-devops]
}
