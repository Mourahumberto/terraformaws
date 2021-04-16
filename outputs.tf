output "vpc_id" {
  value = module.tfm_vpc.vpc_id
}

output "subnet_private" {
    value = module.tfm_vpc.subnet_private
}

output "subnet_public" {
    value = module.tfm_vpc.subnet_public
}