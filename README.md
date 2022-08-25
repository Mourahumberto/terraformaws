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

