# Obrigatorias
variable "bucket_name" {
  description = "O nome unico para o bucket S3. Deve ser globalmente unico."
  type        = string
}

variable "eks_iam_user_name" {
  description = "Nome do usuario IAM que controlara o EKS e sera associado as politicas de acesso do cluster."
  type        = string
}

variable "eks_cluster_name" {
  description = "Nome do cluster EKS. Exemplo: fiap-12soat-fase5-joaodainese"
  type        = string
}

# Opcionais
variable "aws_region" {
  description = "A regiao da AWS onde os recursos serao criados."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "O ambiente ao qual o recurso pertence (ex: Dev, Staging, Prod)."
  type        = string
  default     = "Dev"
}

variable "project_name" {
  description = "Nome do projeto para ser usado em tags."
  type        = string
  default     = "FIAP 12SOAT Fase 5"
}

variable "project_identifier" {
  description = "Identificador unico do projeto para ser usado em tags."
  type        = string
  default     = "fiap-12soat-fase5"
}

variable "cidr_vpc" {
  description = "O bloco CIDR para a VPC."
  type        = string
  default     = "10.1.0.0/16"
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade na regiao escolhida onde as subnets serao criadas (deve combinar com aws_region)."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "eks_node_instance_types" {
  description = "Lista de tipos de instancia para os nos do EKS."
  type        = list(string)
  default     = ["t3.small"]
}

variable "eks_node_disk_size" {
  description = "Tamanho do disco em GB a ser anexado a cada no do EKS."
  type        = number
  default     = 20
}

variable "eks_node_scaling_desired_size" {
  description = "Numero desejado de nos no grupo do EKS."
  type        = number
  default     = 2
}

variable "eks_node_scaling_max_size" {
  description = "Numero maximo de nos no grupo do EKS."
  type        = number
  default     = 3
}

variable "eks_node_scaling_min_size" {
  description = "Numero minimo de nos no grupo do EKS."
  type        = number
  default     = 1
}

variable "new_relic_license_key" {
  description = "Chave de licenca do New Relic para monitoramento do cluster"
  type        = string
  sensitive   = true
}

variable "upload_s3_bucket_name" {
  description = "Nome do bucket S3 para upload de diagramas."
  type        = string
  default     = "fiap-12soat-fase5-upload-diagramas"
}

variable "sqs_upload_diagrama_concluido_name" {
  description = "Nome da fila SQS de notificacao de upload de diagrama concluido (Upload -> Processamento)"
  type        = string
  default     = "fase5-upload-diagrama-concluido"
}

variable "sqs_processamento_diagrama_iniciado_name" {
  description = "Nome da fila SQS de notificacao de processamento de diagrama iniciado (Processamento -> Relatorio)"
  type        = string
  default     = "fase5-processamento-diagrama-iniciado"
}

variable "sqs_processamento_diagrama_analisado_name" {
  description = "Nome da fila SQS de notificacao de processamento de diagrama analisado (Processamento -> Relatorio)"
  type        = string
  default     = "fase5-processamento-diagrama-analisado"
}

variable "sqs_processamento_diagrama_erro_name" {
  description = "Nome da fila SQS de notificacao de erro no processamento de diagrama (Processamento -> Relatorio)"
  type        = string
  default     = "fase5-processamento-diagrama-erro"
}
