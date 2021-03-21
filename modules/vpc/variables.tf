variable "profile" {
  description = "AWS Profile"
}

variable "region" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1"
}

variable "az_a" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1a"
}

variable "az_b" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1b"
}

variable "az_c" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1c"
}

variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  description = "Platform Core VPC."
}

variable "public_a_cidr" {
  default     = "10.20.1.0/24"
  description = "Public subnet - AZ a"
}

variable "public_b_cidr" {
  default     = "10.20.2.0/24"
  description = "Public subnet - AZ b"
}

variable "public_c_cidr" {
  default     = "10.20.3.0/24"
  description = "Public subnet - AZ c"
}

variable "private_a_cidr" {
  default     = "10.20.4.0/24"
  description = "Private subnet - AZ a"
}

variable "private_b_cidr" {
  default     = "10.20.5.0/24"
  description = "Public subnet - AZ b"
}

variable "private_c_cidr" {
  default     = "10.20.6.0/24"
  description = "Public subnet - AZ c"
}

variable "data_a_cidr" {
  default     = "10.20.7.0/24"
  description = "Data subnet - AZ a"
}

variable "data_b_cidr" {
  default     = "10.20.8.0/24"
  description = "Data subnet - AZ b"
}

variable "data_c_cidr" {
  default     = "10.20.9.0/24"
  description = "Data subnet - AZ c"
}