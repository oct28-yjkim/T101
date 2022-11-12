variable "vpc_name" {
    default = "simple-devops-test"
    description = "name of vpc"
}

variable "vpc_cidr" {
  default = "172.31.0.0/16"
  description = "top cibr"
}

variable "image_id" {
  default = "ami-0c802847a7dd848c0"
  description = "variable of image"
}

variable "instance_type" {
  default = "c5.large"
  description = "default flavors in lc"
}

variable "key_name" {
  default = "yjkim1"
  description = "default ssh key name"
}
