resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "Main Vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet A"
  }
}
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet B"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.30.0/24"
  availability_zone       = "us-east-2a"
  tags = {
    Name = "Private Subnet A"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.40.0/24"
  availability_zone       = "us-east-2b"
  tags = {
    Name = "Private Subnet B"
  }
}

resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Main Internet Gateway"
  }
}

resource "aws_route_table" "vpv_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Main Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_internet_gateway.id
  }
}

resource "aws_route_table_association" "public_rt_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.vpv_route_table.id
}

resource "aws_route_table_association" "public_rt_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.vpv_route_table.id
}
