variable "public_security_group_id" {
  type = string
}


variable "private_security_group_id" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_ec2_1" {
  type = string
  default = ""
}

variable "public_ec2_2" {
  type = string
  default = ""
}

variable "private_ec2_1" {
  type = string
  default = ""
}

variable "private_ec2_2" {
  type = string
  default = ""
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}