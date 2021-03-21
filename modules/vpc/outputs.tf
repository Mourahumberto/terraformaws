output "vpc_eip_nat_a" {
  value = aws_eip.vpc_eip_1.public_ip
}

output "vpc_eip_nat_b" {
  value = aws_eip.vpc_eip_2.public_ip
}

output "vpc_eip_nat_c" {
  value = aws_eip.vpc_eip_3.public_ip
}

output "route_table_private_a" {
  value = aws_route_table.private_a.id
}

output "route_table_private_b" {
  value = aws_route_table.private_b.id
}

output "route_table_private_c" {
  value = aws_route_table.private_c.id
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

# output "route_table_private_ids" {
#   value = {
#     private_a = "${aws_route_table.private_a.id}"
#     private_b = "${aws_route_table.private_b.id}"
#     private_c = "${aws_route_table.private_c.id}"
#   }
# }