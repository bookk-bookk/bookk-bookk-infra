resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_subnet.public_subnet.cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block     = aws_subnet.private_subnet.cidr_block
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "bookk_route_table"
  }
}
