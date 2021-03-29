
variable "appKey" {
    type = string
    default = null
}

variable "name" {
    type = string
    default = null
}

variable "ami" {
    type = string
    default = null
}

variable "instance_type" {
    type = string
    default = null
}

variable "subnet_id" {
    type = string
    default = null
}

variable "sg" {
    type = list
    default = []
}

variable "ec2_count" {
    type = number
    default = null
}

variable "user_data" {
  type = string
  default = null
}