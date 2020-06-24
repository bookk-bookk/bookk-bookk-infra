resource "aws_vpc" "main" {
  cidr_block           = "11.0.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.tag_name
  }
}

resource "aws_subnet" "public_subnet" {
  availability_zone       = "ap-northeast-2a"
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "11.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = var.tag_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.tag_name
  }
}
