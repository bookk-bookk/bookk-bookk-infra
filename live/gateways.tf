resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "bookk_igw"
  }
}

resource "aws_eip" "nateip" {
  vpc = "true"
  tags = {
    Name = "bookk_nateip"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "bookk_natgw"
  }
}
