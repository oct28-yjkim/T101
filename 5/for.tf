variable "name" {
  type = list(string)
  default = ["y", "j", "k", "i", "m"]
}

output "upper_name" {
  value = [for name in var.name : upper(name)]
}