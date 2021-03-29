##########
# Provider
##########

provider "aws" {
  region  = "us-east-1"
  profile = "pessoal"
}

module "tfm_vpc" {
  source = "./modules/vpc"

  cidr_block = "10.21.0.0/16"
#  tags = local.environment.vpc.tags

  azs = ["us-east-1a","us-east-1b","us-east-1c"]
  private_subnets = ["10.21.1.0/24","10.21.2.0/24","10.21.3.0/24"]
  public_subnets = ["10.21.100.0/24","10.21.101.0/24","10.21.102.0/24"]

}

module "tfm-aws-sg" {
  source            = "./modules/sg"
  vpc_id = module.tfm_vpc.vpc_id
}

module "ec2_bastion" {
  source = "./modules/ec2"
  name = "bastion"
  ami = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  ec2_count = 1
  sg = [module.tfm-aws-sg.public_sg]
  subnet_id = module.tfm_vpc.subnet_public[0].id
#  user_data = abspath("./ec2_userData/bastion.txt")

#  appKey = devops
}