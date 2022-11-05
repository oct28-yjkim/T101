resource "aws_internet_gateway" "yjkim1_igw" {
  vpc_id = aws_vpc.yjkim1_vpc.id

  tags = {
    Name = "t101-igw"
  }
}

resource "aws_route_table" "yjkim1_rt" {
  vpc_id = aws_vpc.yjkim1_vpc.id

  tags = {
    Name = "t101-rt"
  }
}

resource "aws_route_table_association" "yjkim1_rtassociation1" {
  subnet_id      = aws_subnet.yjkim1_subnet1.id
  route_table_id = aws_route_table.yjkim1_rt.id
}

resource "aws_route_table_association" "yjkim1_rtassociation2" {
  subnet_id      = aws_subnet.yjkim1_subnet2.id
  route_table_id = aws_route_table.yjkim1_rt.id
}

resource "aws_route" "yjkim1_defaultroute" {
  route_table_id         = aws_route_table.yjkim1_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.yjkim1_igw.id
}