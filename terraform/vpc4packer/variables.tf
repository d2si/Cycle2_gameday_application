variable "application" {
  default = "gameday"
}

variable "owner" {
  default = "engie"
}

variable "team_number" {}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_bits" {
  default = "8"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "environment" {
  default = "ProdGameday"
}
