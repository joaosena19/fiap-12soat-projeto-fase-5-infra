[![Deploy](https://github.com/joaosena19/fiap-12soat-projeto-fase-5-infra/actions/workflows/deploy.yaml/badge.svg)](https://github.com/joaosena19/fiap-12soat-projeto-fase-5-infra/actions/workflows/deploy.yaml)

# Identificação

Aluno: João Pedro Sena Dainese  
Registro FIAP: RM365182  

Turma 12SOAT - Software Architecture  
Grupo individual  
Grupo 93  

Discord: joaodainese  
Email: joaosenadainese@gmail.com  

## Sobre este Repositório

Este repositório contém apenas parte do projeto completo da Fase 5. Para visualizar a documentação completa, diagramas de arquitetura, e todos os componentes do projeto, acesse: [Documentação Completa - Fase 5](https://github.com/joaosena19/fiap-12soat-projeto-fase-5-documentacao)

## Descrição

Infraestrutura compartilhada da AWS usando Terraform: VPC, subnets, cluster EKS, Network Load Balancer, tópicos SNS, filas SQS, bucket S3, permissões IAM e integração com New Relic para monitoramento. Fornece a base de rede e compute para todos os microsserviços do projeto. O banco de dados de cada microsserviço é provisionado no próprio repositório do serviço.

## Tecnologias Utilizadas

- **Terraform** - Infraestrutura como código
- **AWS EKS** - Kubernetes gerenciado
- **AWS VPC** - Rede isolada
- **Network Load Balancer** - Distribuição de tráfego externo para os serviços
- **Amazon SNS + SQS** - Tópicos e filas para mensageria assíncrona
- **Amazon S3** - Armazenamento de arquivos e backend do Terraform
- **AWS IAM** - Permissões e roles
- **New Relic** - Monitoramento e observabilidade
