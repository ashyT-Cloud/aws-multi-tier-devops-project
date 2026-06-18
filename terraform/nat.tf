## --- Elastic IP ---
resource "aws_eip" "nat_eip" {

  domain = "vpc"

  tags = {
    Name = "MultiTier-NAT-EIP"
  }
}

## --- NAT Gateway ---
resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.public_az1.id

  tags = {
    Name = "MultiTier-NAT"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

## --- Private Route Table ---
resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private-RT"
  }
}

## --- Associate Private Subnets ---
resource "aws_route_table_association" "private_az1" {

  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_az2" {

  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_rt.id
}
