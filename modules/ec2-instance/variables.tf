variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "lb_ip" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
  default = ""
}

variable "public_subnet_2_id" {
  type = string
  default = ""
}

variable "private_subnet_1_id" {
  type = string
  default = ""
}

variable "private_subnet_2_id" {
  type = string
  default = ""
}

variable "public_security_group_id" {
  type = string
}


variable "private_security_group_id" {
  type = string
}