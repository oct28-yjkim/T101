terraform {
  backend "s3" {
      bucket         = "se4ofnight-t101study-tfstate" 
      key            = "terraform.tfstate"
      region         = "ap-northeast-2"
      encrypt        = true
      dynamodb_table = "terraform-locks" 
  }
}