output "vpc_id" {
    value = aws_vpc.main.id
}

output "subnet_private" {
    value = aws_subnet.private
}

output "subnet_public" {
    value = aws_subnet.public
}

#output "appKey" {
#    value = aws_key_pair.ec2key.key_name
#}

#output "bastionKey" {
#    value = aws_key_pair.bastion_key.key_name
#}