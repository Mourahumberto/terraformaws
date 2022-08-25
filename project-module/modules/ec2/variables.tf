
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
    type = list
    default = []
}

variable "sg" {
    type = list
    default = []
}

variable "instance_count" {
    type = number
    default = null
}

variable "user_data" {
  type = string
  default = null
}

# variable "teste" {
#     type = number
#     default = null
# }