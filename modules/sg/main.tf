##########################
# Security Group to Public
##########################

resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Public Host"
  vpc_id = var.vpc_id

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
