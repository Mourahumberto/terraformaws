# Doc Kubernetes

- Concentrado de todas minhas experiências com Terraform

> Author: **[Humberto Moura](https://github.com/Mourahumberto)**

## Sumário

1. [Conceitos Terraform](Kubernetes/README.md)
1. [Docker](docker/docker.md)
1. [Eksctl](eksctl/README.md)
1. [Helm](helm/README.md)
1. [Openshift](openshift/README.md)


## Blocos importantes

### Provider
- é o bloco que o terraform usa para se conectar a um provider. a forma que iremos nos autenticar com a nuvem.

ex1:
Provider "algum provider" {
    // imputs de cada provider
}

ex2:
provider "aws" {
  region  = "us-east-1"
  profile = "pessoal"
}

### Resorce
- Ele irá criar algum recurso no provider
- O "nome" no resource é uma referência interna do terraform.
- sempre procurar os imputs na própria documentação do terraform é super importante saber quais são os imputs e outputs de cada recurso.

resource "Provider_tipo" "nome"{
    // Imputs para o resource
}

- utilizando o output do resource

resource "aws_instance" "web" {
    ami             = data.aws_ami.ubuntu.id
    instance_type   = "t2.micro"
}

aws_instance.web.arn -> output do arn

### Variavel

variable "nome_var" {
    type = "tipo da variável"
    default = "valor padrão caso não seja passado em uma pipeline ou em tempo de execução"
}

### output

output "nome_output" {
    value = "aws_instance.name.arn"
}

output "nome_da_var" {
    value = var.nome_da_var
}

### data
- é um bloco que você consegue reconhecer recursos já criados no providers seja elo terraform ou não.
- podemos usar para atrelar esse data a um recurso em tempo de execução.

data "provider_tipo" "nome"{
    // imputs para o data
}

## Estrutura de arquivos

- é importante que o projeto esteja bem estruturado, com pastas divididas para cada propósito.

```
-- PROJECT-DIRECTORY/
   -- modules/
      -- <service1-name>/
         -- main.tf
         -- variables.tf
         -- outputs.tf
         -- provider.tf
         -- README
      -- <service2-name>/
         -- main.tf
         -- variables.tf
         -- outputs.tf
         -- provider.tf
         -- README
      -- ...other…

   -- environments/
      -- dev/
         -- backend.tf
         -- main.tf
         -- outputs.tf
         -- variables.tf
         -- terraform.tfvars

      -- qa/
         -- backend.tf
         -- main.tf
         -- outputs.tf
         -- variables.tf
         -- terraform.tfvars

      -- stage/
         -- backend.tf
         -- main.tf
         -- outputs.tf
         -- variables.tf
         -- terraform.tfvars

      -- prod/
         -- backend.tf
         -- main.tf
         -- outputs.tf
         -- variables.tf
         -- terraform.tfvars

```

## Arquivos de configurações separados.

- Não é uma Boa prática concentrar tudo do terraform em apenas um arquivo main.tf
Desta forma, é interessante que se faça a divisão dos arquivos

main.tf - chama modules, locals, e data sources para criar todos os recursos.
variables.tf - Contem as declarações das variáveis usadas no main.
outputs.tf - Contem os outputs dos recursos criados no main.
versions.tf - contem os requerimentos do provider e do próprio terraform
terraform.tfvars - contains variables values and should not be used anywhere. pode ser usado como prod.tfvars qa.tfvars

## Siga estrutura padrão

- Use sempre módulos.

- Trate sua aplicação como projetos independentes, que cada aplicação com o que for necessário
pra ela fique em um diretório.
- Use diretórios separados para cada ambiente (dev,qa,prod)
- Cada diretório de enviroments corresponde a um workspace.
- Os módulos devem ser compartilhados entre os enviroments
- cada enviroment deve ter seu próprio backend
- Arquivos estáticos que não serão executados pelo terraform devem ficar em um diretório files/
- coloque o arquivos files separados dos hcl e referencie usando file()
- Arquivos que serão lidos pelo terraform usando o templatefile function, use a terminação .tftpl
- Templates devem ficar no diretório templates/
  
## Estruturando o código

- Não coloque valores hardcode, quando for possível colocar como variável ou data source
- Use nomeclaturas e formatações já convecionado para serem compreensíveis por todos.
- não repita o nome do recurso com o tipo do recurso
  ex:
  resource "aws_route_table" "public" {} \\ok
  resource "aws_route_table" "public_route_table" {} \\ not ok

- Declare todas as variáveis em variables.tf
- use nomes descritivos na variable, com o seu propósito
- Sempre coloque descrisão nas variáveis.
- Ordene as keys nas variáveis nessa ordem. (description,type,default,validation).
- Coloque default valores sempre que a variável for independente de ambiente. caso ele ja tenha valores default por ambiente, não será necessário.
-  Use nome de variáveis no plural quando ela for do tipo list() ou map().
-  quando for criado variáveis com valores como memória ram ou hd deve ser colocado o nome com a unidade
  ex:
  ram_size_gb
- Nos casos em que um literal é reutilizado em vários lugares, você pode usar um valor local sem expô-lo como uma variável.

## Convenções de Outputs

- Organize todos os outputs em outputs.tf
- Sempre coloque descrição nos outputs mesmo quando julgares óbivio
- siga o padrão de nomes do output name_type_attribute
- Documente a descrição de output no readme também
  
## Boas práticas de segurança

- nunca deixe o estado do terraform na máquina local ou no repositório
- Use remote state(s3, gcp cloud storage...) para que possa ser usado o terraform de forma colaborativa.
- Usando remote state você separa os estados de seu controle de dversão.
- nunca commit seu remote state(.tfstate) no seu controle de versão. sempre use o .gitgnore para esse arquivo.
- não altere o remote state manualmente.
- encrypt o state
- faça o backup do seu remote state
- use um state por enviroment


## setup seu state lock

- existem vários casos em que você pode ter perdas de dados no seu state. quando várias pessoas tentam rodar 
ao mesmo tempo o terraform. Desta forma é importante locked o state quando já está em uso.
- no backend você pode criar um state lock, o azure blob storage aceita nativamente já o s3 necessita de um dynamodb

```
terraform {
  backend "s3" {
    bucket         = "YOUR_S3_BUCKET_NAME"
    dynamodb_table = "YOUR_DYNAMODB_TABLE_NAME"
    key            = "prod_terraform.tfstate"
    region         = "us-east-1"
        
    #  Authentication
    profile        = "MY_PROFILE"
  }
} 
```

## Rode continus audit

- Depois que o terraform apply rodar em seguida rode checks de segurança automatizadas.
- InSpec and Serverspec são boas escolhas.
  
## Use sensitivas flags.

- Para que certas credenciais não sejam mostradas no plan sempre use a flag sensitive.

```
variable "db_password" {
  description = "Database administrator password."
  type        = string
  sensitive   = true
}
```

## Use arquivos de variáveis definidas

- Com muitas variáveis e ambientes diferentes o melhor é usar arquivos de variáveis (.tfvars)
- os arquivos podem serpassados na hora do apply ou plan
terraform apply -var-file=”prod.tfvars”

## Modulos

- é sempre sugerido usar o módulo criado pelo registry do terraform sempre que possívweel, não é preciso criar algo já existente
- módulos compartilhados não devem conter backends chumbados no módulo.
- sempre declare seu backend e providers no root module
- é importante evitar que um único root module fique grande de mais, menos recurso é mais fácil resolver um problema.

## Teste

- é importante usar várias ferramentas de teste para uma melhor cobertura de código.
- para testes estáticos no terraform (terraform validate e ferramentas como tflint, config-lint, Checkov, Terrascan, tfsec, Deepsource.)
- Para testes de integração(Terratest, Kitchen-Terraform, InSpec)


# Projetos

1- Projeto com estrutura simples.
