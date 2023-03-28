terraform init -backend-config=backend-dev.hcl
<!-- terraform workspace new dev -->
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"

PRD

terraform init -backend-config=backend-prd.hcl
<!-- terraform workspace new prd -->
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
