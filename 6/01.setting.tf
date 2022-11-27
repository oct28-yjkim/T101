terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "se4ofnight"
  region  = "ap-northeast-2"
}

data "aws_iam_user" "se4ofnight" {
  user_name = "yjkim"
}

output "who" {
  value = data.aws_iam_user.se4ofnight.user_name
}