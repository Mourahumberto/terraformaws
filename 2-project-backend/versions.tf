##########
# Provider
##########

provider "aws" {
  region  = "us-east-1"
  profile = "${terraform.workspace}"
}

terraform {
backend "s3" {}
}