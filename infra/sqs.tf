# Filas Amazon SQS para messaging entre microsservicos

# Filas dedicadas para fan-out do topico upload-diagrama-concluido (SNS -> SQS)
# Cada consumidor tem sua propria fila para receber todas as mensagens do topico

# Fila dedicada ao Processamento para consumo do topico upload-diagrama-concluido
resource "aws_sqs_queue" "upload_diagrama_concluido_processamento" {
  name                       = var.sqs_upload_diagrama_concluido_processamento_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_upload_diagrama_concluido_processamento_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Fila dedicada ao Relatorio para consumo do topico upload-diagrama-concluido
resource "aws_sqs_queue" "upload_diagrama_concluido_relatorio" {
  name                       = var.sqs_upload_diagrama_concluido_relatorio_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_upload_diagrama_concluido_relatorio_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Fila para notificacao de upload de diagrama rejeitado (Upload -> Relatorio)
resource "aws_sqs_queue" "upload_diagrama_rejeitado" {
  name                       = var.sqs_upload_diagrama_rejeitado_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_upload_diagrama_rejeitado_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Fila para notificacao de processamento de diagrama iniciado (Processamento -> Relatorio)
resource "aws_sqs_queue" "processamento_diagrama_iniciado" {
  name                       = var.sqs_processamento_diagrama_iniciado_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_processamento_diagrama_iniciado_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Fila para notificacao de processamento de diagrama analisado (Processamento -> Relatorio)
resource "aws_sqs_queue" "processamento_diagrama_analisado" {
  name                       = var.sqs_processamento_diagrama_analisado_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_processamento_diagrama_analisado_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Fila para notificacao de erro no processamento de diagrama (Processamento -> Relatorio)
resource "aws_sqs_queue" "processamento_diagrama_erro" {
  name                       = var.sqs_processamento_diagrama_erro_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_processamento_diagrama_erro_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Fila para solicitacao de geracao de relatorios
resource "aws_sqs_queue" "relatorio_solicitar_geracao" {
  name                       = var.sqs_relatorio_solicitar_geracao_name
  visibility_timeout_seconds = 120
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  tags = {
    Name              = var.sqs_relatorio_solicitar_geracao_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# SNS Topics para pub/sub entre microsservicos (MassTransit)
resource "aws_sns_topic" "upload_diagrama_concluido" {
  name = var.sqs_upload_diagrama_concluido_name

  tags = {
    Name              = var.sqs_upload_diagrama_concluido_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

resource "aws_sns_topic" "upload_diagrama_rejeitado" {
  name = var.sqs_upload_diagrama_rejeitado_name

  tags = {
    Name              = var.sqs_upload_diagrama_rejeitado_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

resource "aws_sns_topic" "processamento_diagrama_iniciado" {
  name = var.sqs_processamento_diagrama_iniciado_name

  tags = {
    Name              = var.sqs_processamento_diagrama_iniciado_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

resource "aws_sns_topic" "processamento_diagrama_analisado" {
  name = var.sqs_processamento_diagrama_analisado_name

  tags = {
    Name              = var.sqs_processamento_diagrama_analisado_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

resource "aws_sns_topic" "processamento_diagrama_erro" {
  name = var.sqs_processamento_diagrama_erro_name

  tags = {
    Name              = var.sqs_processamento_diagrama_erro_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

resource "aws_sns_topic" "relatorio_solicitar_geracao" {
  name = var.sqs_relatorio_solicitar_geracao_name

  tags = {
    Name              = var.sqs_relatorio_solicitar_geracao_name
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
    Environment       = var.environment
  }
}

# Subscriptions SNS -> SQS (fan-out: upload-diagrama-concluido -> 2 filas)
resource "aws_sns_topic_subscription" "upload_diagrama_concluido_processamento_to_sqs" {
  topic_arn = aws_sns_topic.upload_diagrama_concluido.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.upload_diagrama_concluido_processamento.arn

  raw_message_delivery = true
}

resource "aws_sns_topic_subscription" "upload_diagrama_concluido_relatorio_to_sqs" {
  topic_arn = aws_sns_topic.upload_diagrama_concluido.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.upload_diagrama_concluido_relatorio.arn

  raw_message_delivery = true
}

resource "aws_sns_topic_subscription" "upload_diagrama_rejeitado_to_sqs" {
  topic_arn = aws_sns_topic.upload_diagrama_rejeitado.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.upload_diagrama_rejeitado.arn

  raw_message_delivery = true
}

resource "aws_sns_topic_subscription" "processamento_diagrama_iniciado_to_sqs" {
  topic_arn = aws_sns_topic.processamento_diagrama_iniciado.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.processamento_diagrama_iniciado.arn

  raw_message_delivery = true
}

resource "aws_sns_topic_subscription" "processamento_diagrama_analisado_to_sqs" {
  topic_arn = aws_sns_topic.processamento_diagrama_analisado.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.processamento_diagrama_analisado.arn

  raw_message_delivery = true
}

resource "aws_sns_topic_subscription" "processamento_diagrama_erro_to_sqs" {
  topic_arn = aws_sns_topic.processamento_diagrama_erro.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.processamento_diagrama_erro.arn

  raw_message_delivery = true
}

resource "aws_sns_topic_subscription" "relatorio_solicitar_geracao_to_sqs" {
  topic_arn = aws_sns_topic.relatorio_solicitar_geracao.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.relatorio_solicitar_geracao.arn

  raw_message_delivery = true
}

# Policy na fila SQS para permitir que o SNS envie mensagens
resource "aws_sqs_queue_policy" "upload_diagrama_concluido_processamento_sns_policy" {
  queue_url = aws_sqs_queue.upload_diagrama_concluido_processamento.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.upload_diagrama_concluido_processamento.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.upload_diagrama_concluido.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "upload_diagrama_concluido_relatorio_sns_policy" {
  queue_url = aws_sqs_queue.upload_diagrama_concluido_relatorio.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.upload_diagrama_concluido_relatorio.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.upload_diagrama_concluido.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "upload_diagrama_rejeitado_sns_policy" {
  queue_url = aws_sqs_queue.upload_diagrama_rejeitado.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.upload_diagrama_rejeitado.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.upload_diagrama_rejeitado.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "processamento_diagrama_iniciado_sns_policy" {
  queue_url = aws_sqs_queue.processamento_diagrama_iniciado.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.processamento_diagrama_iniciado.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.processamento_diagrama_iniciado.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "processamento_diagrama_analisado_sns_policy" {
  queue_url = aws_sqs_queue.processamento_diagrama_analisado.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.processamento_diagrama_analisado.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.processamento_diagrama_analisado.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "processamento_diagrama_erro_sns_policy" {
  queue_url = aws_sqs_queue.processamento_diagrama_erro.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.processamento_diagrama_erro.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.processamento_diagrama_erro.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "relatorio_solicitar_geracao_sns_policy" {
  queue_url = aws_sqs_queue.relatorio_solicitar_geracao.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.relatorio_solicitar_geracao.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.relatorio_solicitar_geracao.arn
          }
        }
      }
    ]
  })
}

# IAM Policy para acesso ao SQS e SNS pelos pods do EKS
resource "aws_iam_policy" "sqs_access" {
  name        = "${var.project_identifier}-sqs-access-policy"
  description = "Policy para permitir que pods do EKS acessem filas SQS e topicos SNS para messaging"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = [
          aws_sqs_queue.upload_diagrama_concluido_processamento.arn,
          aws_sqs_queue.upload_diagrama_concluido_relatorio.arn,
          aws_sqs_queue.upload_diagrama_rejeitado.arn,
          aws_sqs_queue.processamento_diagrama_iniciado.arn,
          aws_sqs_queue.processamento_diagrama_analisado.arn,
          aws_sqs_queue.processamento_diagrama_erro.arn,
          aws_sqs_queue.relatorio_solicitar_geracao.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:SetTopicAttributes",
          "sns:Subscribe",
          "sns:CreateTopic",
          "sns:ListSubscriptionsByTopic"
        ]
        Resource = [
          aws_sns_topic.upload_diagrama_concluido.arn,
          aws_sns_topic.upload_diagrama_rejeitado.arn,
          aws_sns_topic.processamento_diagrama_iniciado.arn,
          aws_sns_topic.processamento_diagrama_analisado.arn,
          aws_sns_topic.processamento_diagrama_erro.arn,
          aws_sns_topic.relatorio_solicitar_geracao.arn
        ]
      }
    ]
  })

  tags = {
    Name              = "${var.project_identifier}-sqs-access-policy"
    ProjectIdentifier = var.project_identifier
    Service           = "messaging"
  }
}

# Anexar SQS policy a role dos nos do EKS
resource "aws_iam_role_policy_attachment" "eks_node_sqs_access" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.sqs_access.arn
}
