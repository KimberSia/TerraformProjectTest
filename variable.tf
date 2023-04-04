variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "vpc_name" {
  type    = string
  default = "vpc-0b52159f7541497e8"
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "private_subnets" {
  default = {
    "private_subnet_1" = 1

  } 
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
  }
}
variable "my_ip" {
  description = "public_ip_address"
}