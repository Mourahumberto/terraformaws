output "ids" {
  value = module.ec2_cluster.id
}

output "public_ip" {
  value = module.ec2_cluster.public_ip
}

output "private_ip" {
  value = module.ec2_cluster.private_ip
}