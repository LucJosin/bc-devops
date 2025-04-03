variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "ssh_allowed_cidr" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "ec2_tags" {
  type = map(string)
}
