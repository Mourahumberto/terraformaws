terraform init -backend-config=backend-dev.hcl
terraform workspace new dev
terraform plan
terraform apply

PRD

terraform init -backend-config=backend-prd.hcl
terraform workspace new prd
terraform plan
terraform apply