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

output "relatorio_listener_arn" {
  description = "ARN do Listener do Relatorio Service"
  value       = aws_lb_listener.relatorio_listener.arn
}

# Target Group outputs for microservices
output "upload_target_group_arn" {
  description = "ARN do Target Group do Upload Service"
  value       = aws_lb_target_group.upload_tg.arn
}

output "relatorio_target_group_arn" {
  description = "ARN do Target Group do Relatorio Service"
  value       = aws_lb_target_group.relatorio_tg.arn
}

# SQS Queue outputs
output "sqs_upload_diagrama_concluido_processamento_url" {
  description = "URL da fila SQS dedicada ao Processamento para upload-diagrama-concluido"
  value       = aws_sqs_queue.upload_diagrama_concluido_processamento.url
}

output "sqs_upload_diagrama_concluido_processamento_arn" {
  description = "ARN da fila SQS dedicada ao Processamento para upload-diagrama-concluido"
  value       = aws_sqs_queue.upload_diagrama_concluido_processamento.arn
}

output "sqs_upload_diagrama_concluido_relatorio_url" {
  description = "URL da fila SQS dedicada ao Relatorio para upload-diagrama-concluido"
  value       = aws_sqs_queue.upload_diagrama_concluido_relatorio.url
}

output "sqs_upload_diagrama_concluido_relatorio_arn" {
  description = "ARN da fila SQS dedicada ao Relatorio para upload-diagrama-concluido"
  value       = aws_sqs_queue.upload_diagrama_concluido_relatorio.arn
}

output "sqs_upload_diagrama_rejeitado_url" {
  description = "URL da fila SQS de upload de diagrama rejeitado"
  value       = aws_sqs_queue.upload_diagrama_rejeitado.url
}

output "sqs_upload_diagrama_rejeitado_arn" {
  description = "ARN da fila SQS de upload de diagrama rejeitado"
  value       = aws_sqs_queue.upload_diagrama_rejeitado.arn
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

output "sqs_relatorio_solicitar_geracao_url" {
  description = "URL da fila SQS de solicitacao de geracao de relatorios"
  value       = aws_sqs_queue.relatorio_solicitar_geracao.url
}

output "sqs_relatorio_solicitar_geracao_arn" {
  description = "ARN da fila SQS de solicitacao de geracao de relatorios"
  value       = aws_sqs_queue.relatorio_solicitar_geracao.arn
}

# SNS Topic outputs
output "sns_upload_diagrama_concluido_arn" {
  description = "ARN do topico SNS de upload de diagrama concluido"
  value       = aws_sns_topic.upload_diagrama_concluido.arn
}

output "sns_upload_diagrama_rejeitado_arn" {
  description = "ARN do topico SNS de upload de diagrama rejeitado"
  value       = aws_sns_topic.upload_diagrama_rejeitado.arn
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

output "sns_relatorio_solicitar_geracao_arn" {
  description = "ARN do topico SNS de solicitacao de geracao de relatorios"
  value       = aws_sns_topic.relatorio_solicitar_geracao.arn
}

# S3 Upload bucket outputs
output "upload_bucket_name" {
  description = "Nome do bucket S3 para upload de diagramas"
  value       = aws_s3_bucket.upload_diagramas.bucket
}

output "upload_bucket_arn" {
  description = "ARN do bucket S3 para upload de diagramas"
  value       = aws_s3_bucket.upload_diagramas.arn
}
