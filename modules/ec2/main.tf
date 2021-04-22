resource "aws_instance" "services_1" {
  count = var.instance_count
  ami                    = var.ami
  
  key_name               = "devops"
  instance_type          = var.instance_type
  
  vpc_security_group_ids = var.sg

  subnet_id              = var.subnet_id[0]

}