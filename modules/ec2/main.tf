module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = var.name
  instance_count         = var.ec2_count

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "devops"
  monitoring             = false
  vpc_security_group_ids = var.sg
  subnet_id              = var.subnet_id

#  user_data = file(var.user_data)
}