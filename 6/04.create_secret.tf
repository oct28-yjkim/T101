variable "password" {
  type    = string
  default = "P@ssw0rd"
}

resource "aws_secretsmanager_secret" "password" {
  name = "password"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = jsonencode({ "password" = var.password })
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = "password"
}

locals {
  password = jsondecode(data.aws_secretsmanager_secret_version.password.secret_string)["password"]
  password_object = jsondecode(data.aws_secretsmanager_secret_version.password.secret_string)
}