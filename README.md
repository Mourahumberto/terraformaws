# Terraform AWS
Neste Repo estarei criando uma infraestrutura na AWS uktilizando módulos do terraform.

# Configure AWS CLI 
> ~/.aws/credentials (Linux & Mac)

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnSAMPLESECRETKEY
```
Veja o [Guia](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) para mais informações

### No local de execução

Inicialize o módulo do terraform
`terraform init`

Criando um plano
`terraform plan -out tfplan`

Execute terraform apply
`terraform apply "tfplan"` 



