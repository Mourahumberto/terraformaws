##########
# Provider
##########
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.tfm_vpc.vpc_id
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "tfm_vpc" {
  source            = "./modules/vpc"
  
  profile = "default"
}

module "tfm-aws-sg" {
  source            = "./modules/sg"

}
####################
# Locals Environment
####################
