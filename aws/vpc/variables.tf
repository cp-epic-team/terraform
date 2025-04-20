variable "project" {
  description = "The name of project"
  type = string
}

variable "cidr_block" {
  description = "This is the cidr block of the aws vpc"
  type = string
}

variable "desired_azs" {
  description = "This is the number of availibility zones"
  type = number
}

variable "public_subnet_no" {
  description = "This is the number of public subnets"
  type = number
}

variable "private_subnet_no" {
  description = "This is the number of private subnets"
  type = number
}