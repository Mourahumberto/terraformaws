variable "cidr_block" {
  type = string
  default = null
}
variable "tags" {
  default = null
}

variable "project" {
  type = string
  default = null
}

variable "private_subnets" {
  type = list(string)
  default = []
}
variable "public_subnets" {
  type = list(string)
  default = []
}

variable "azs" {
  type = list(string)
  default = []
}

variable "path_rsa_public_key" {
  type = string
  default = null
}

variable "path_rsa_bastion_key" {
  type = string
  default = null
}