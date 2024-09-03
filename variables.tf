variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
}

variable "enable_vpn_gateway" {
  type = bool
}

variable "create_multiple_intra_route_tables" {
  type = bool
}

variable "create_multiple_public_route_tables" {
  type = bool
}

variable "terraform_tag" {
  type = string
}

variable "environment_tag" {
  type = string
}
# variable "cidr_block" {
#   type = string
# }

# variable "pub_sub_cidr_block" {
#   type = string
# }

# variable "pvt_sub_1_cidr_block" {
#   type = string
# }

# variable "pvt_sub_2_cidr_block" {
#   type = string
# }
# variable "ami_id" {
#   type = string
# }

# variable "inst_type" {
#   type = string
# }

# variable "ec2_pub_sub" {
#   type = string
# }

# variable "ec2_pvt_sub_1" {
#   type = string
# }

# variable "ec2_pvt_sub_2" {
#   type = string
# }

# variable "db_name" {
#   type = string
# }