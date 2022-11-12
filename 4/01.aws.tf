terraform {
  backend "s3" {
    bucket = "yjkim1.terraform.state"
    key = "log/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = true
    dynamodb_table = "terraform-lock"
    acl = "bucket-owner-full-control"
  }
}

# Configure the AWS Provider
provider "aws" {
  region =  "ap-southeast-1"
}
