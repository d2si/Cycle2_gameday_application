variable "application" {
  default = "Cycle2-gameday"
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

variable "web_ami" {
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "../sshkey/gameday_key.pub"
}

variable "asg_min" {
  default = "0"
}

variable "asg_max" {
  default = "3"
}

variable "asg_desired" {
  default = "1"
}

variable "asg_health_check_type" {
  default = "EC2"
}

variable "asg_health_check_grace_period" {
  default = "180"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "ddb_read_cap" {
  default = "100"
}

variable "ddb_write_cap" {
  default = "100"
}

variable "environment" {
  default = "Cycle2 Gameday"
}

variable "version1" {
  default = "Grey"
}

variable "aws_sdk_version" {
  default = "latest"
}

variable "api_url" {
  default = "https://k13mtaqgj1.execute-api.eu-west-1.amazonaws.com/"
}
