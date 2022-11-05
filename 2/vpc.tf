provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_vpc" "yjkim1_vpc" {
  cidr_block       = "10.10.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "t101-study"
  }
}

