resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.2.0/24"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "public-subnet-c"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "simple - Internet Gateway"
  }
}

resource "aws_route_table" "vpc_public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_igw.id
    }

    tags = {
        Name = "Public Subnets Route Table for simple"
    }
}

resource "aws_route_table_association" "vpc_apsoutheast1a_public" {
    subnet_id = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.vpc_public.id
}

resource "aws_route_table_association" "vpc_apsoutheast1c_public" {
    subnet_id = aws_subnet.public_subnet_c.id
    route_table_id = aws_route_table.vpc_public.id
}

# private subnet
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.3.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "private_subnet_a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.4.0/24"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "private_subnet_c"
  }
}

