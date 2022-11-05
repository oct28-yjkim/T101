resource "aws_subnet" "yjkim1_subnet1" {
  vpc_id     = aws_vpc.yjkim1_vpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "t101-subnet1"
  }
}

resource "aws_subnet" "yjkim1_subnet2" {
  vpc_id     = aws_vpc.yjkim1_vpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "t101-subnet2"
  }
}