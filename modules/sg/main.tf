#############
# Data Source
#############

# data "aws_vpc" "main_vpc" {
#   tags = {
#     Name = "platform-core-vpc"
#   }
# }
##########################
# Security Group to Public
##########################

resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Public Host"
  vpc_id = "default"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-in-bpp"
  }
}

resource "aws_security_group_rule" "self_in_public_sg" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.public_sg.id

}

resource "aws_security_group_rule" "inbound_in_public_sg" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.ips_inbound
  security_group_id = aws_security_group.public_sg.id

}

#############################
# Security Group to Services
#############################

# resource "aws_security_group" "services_nodes_sg" {
#   name        = "services-${var.project}-nodes-sg"
#   description = "Services Nodes"
#   vpc_id      = "${data.aws_vpc.vpc_platform.id}"

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "services-${var.project}"
#   }
# }

# resource "aws_security_group_rule" "self_in_services_nodes_sg" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   self              = true
#   security_group_id = "${aws_security_group.services_nodes_sg.id}"

#   depends_on = [
#     "aws_security_group.services_nodes_sg"
#   ]
# }

# resource "aws_security_group_rule" "bastion_in_services_nodes_sg" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.services_nodes_sg.id}"
#   source_security_group_id = "${aws_security_group.bastion_sg.id}"

#   depends_on = [
#     "aws_security_group.services_nodes_sg"
#   ]
# }

