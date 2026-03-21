output "vpc_principal_cidr" {
  description = "Bloco CIDR da VPC principal"
  value       = aws_vpc.vpc_principal.cidr_block
}

output "vpc_principal_id" {
  description = "ID da VPC principal"
  value       = aws_vpc.vpc_principal.id
}

output "subnet_publica_cidrs" {
  description = "Blocos CIDR das subnets publicas"
  value       = aws_subnet.subnet_publica[*].cidr_block
}

output "subnet_publica_ids" {
  description = "IDs das subnets publicas"
  value       = aws_subnet.subnet_publica[*].id
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.eks_cluster.name
}

# NLB outputs
output "nlb_dns_name" {
  description = "DNS do Network Load Balancer"
  value       = aws_lb.eks_nlb.dns_name
}

output "nlb_arn" {
  description = "ARN do Network Load Balancer"
  value       = aws_lb.eks_nlb.arn
}

# Listener ARN outputs for microservices
output "upload_listener_arn" {
  description = "ARN do Listener do Upload Service"
  value       = aws_lb_listener.upload_listener.arn
}

output "processamento_listener_arn" {
  description = "ARN do Listener do Processamento Service"
  value       = aws_lb_listener.processamento_listener.arn
}

output "relatorio_listener_arn" {
  description = "ARN do Listener do Relatorio Service"
  value       = aws_lb_listener.relatorio_listener.arn
}

# Target Group outputs for microservices
output "upload_target_group_arn" {
  description = "ARN do Target Group do Upload Service"
  value       = aws_lb_target_group.upload_tg.arn
}

output "processamento_target_group_arn" {
  description = "ARN do Target Group do Processamento Service"
  value       = aws_lb_target_group.processamento_tg.arn
}

output "relatorio_target_group_arn" {
  description = "ARN do Target Group do Relatorio Service"
  value       = aws_lb_target_group.relatorio_tg.arn
}

# SQS Queue outputs
output "sqs_upload_diagrama_concluido_url" {
  description = "URL da fila SQS de upload de diagrama concluido"
  value       = aws_sqs_queue.upload_diagrama_concluido.url
}

output "sqs_upload_diagrama_concluido_arn" {
  description = "ARN da fila SQS de upload de diagrama concluido"
  value       = aws_sqs_queue.upload_diagrama_concluido.arn
}

output "sqs_processamento_diagrama_iniciado_url" {
  description = "URL da fila SQS de processamento de diagrama iniciado"
  value       = aws_sqs_queue.processamento_diagrama_iniciado.url
}

output "sqs_processamento_diagrama_iniciado_arn" {
  description = "ARN da fila SQS de processamento de diagrama iniciado"
  value       = aws_sqs_queue.processamento_diagrama_iniciado.arn
}

output "sqs_processamento_diagrama_analisado_url" {
  description = "URL da fila SQS de processamento de diagrama analisado"
  value       = aws_sqs_queue.processamento_diagrama_analisado.url
}

output "sqs_processamento_diagrama_analisado_arn" {
  description = "ARN da fila SQS de processamento de diagrama analisado"
  value       = aws_sqs_queue.processamento_diagrama_analisado.arn
}

output "sqs_processamento_diagrama_erro_url" {
  description = "URL da fila SQS de erro no processamento de diagrama"
  value       = aws_sqs_queue.processamento_diagrama_erro.url
}

output "sqs_processamento_diagrama_erro_arn" {
  description = "ARN da fila SQS de erro no processamento de diagrama"
  value       = aws_sqs_queue.processamento_diagrama_erro.arn
}

# SNS Topic outputs
output "sns_upload_diagrama_concluido_arn" {
  description = "ARN do topico SNS de upload de diagrama concluido"
  value       = aws_sns_topic.upload_diagrama_concluido.arn
}

output "sns_processamento_diagrama_iniciado_arn" {
  description = "ARN do topico SNS de processamento de diagrama iniciado"
  value       = aws_sns_topic.processamento_diagrama_iniciado.arn
}

output "sns_processamento_diagrama_analisado_arn" {
  description = "ARN do topico SNS de processamento de diagrama analisado"
  value       = aws_sns_topic.processamento_diagrama_analisado.arn
}

output "sns_processamento_diagrama_erro_arn" {
  description = "ARN do topico SNS de erro no processamento de diagrama"
  value       = aws_sns_topic.processamento_diagrama_erro.arn
}

# S3 Upload bucket outputs
output "upload_s3_bucket_name" {
  description = "Nome do bucket S3 para upload de diagramas"
  value       = aws_s3_bucket.upload_diagramas.bucket
}

output "upload_s3_bucket_arn" {
  description = "ARN do bucket S3 para upload de diagramas"
  value       = aws_s3_bucket.upload_diagramas.arn
}
