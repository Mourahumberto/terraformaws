variable "region" {
  description = "EC2 Region for the VPC"
  default     = "us-east-1"
}

variable "project" {
  description = "Project DevOps"
  default     = "project-vpc"
}
variable "vpc_id" {
}
variable "ips_inbound" {
  description = "Ips from BPP"
  type        = list(string)
  default = ["186.207.198.33/32"]
}