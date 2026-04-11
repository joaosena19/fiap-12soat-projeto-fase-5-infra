import {
  to = aws_s3_bucket.bucket_tfstate
  id = var.tfstate_bucket_name
}

resource "aws_s3_bucket" "bucket_tfstate" {
  bucket = var.tfstate_bucket_name

  lifecycle {
    prevent_destroy = true # Como o proprio tfstate esta no bucket, previnimos que ele seja destruido acidentalmente
  }

  tags = {
    Name              = "Bucket ${var.project_name}"
    Environment       = var.environment
    ProjectIdentifier = var.project_identifier
  }
}

resource "aws_s3_bucket" "upload_diagramas" {
  bucket = var.upload_bucket_name

  tags = {
    Name              = "Upload Diagramas ${var.project_name}"
    Environment       = var.environment
    ProjectIdentifier = var.project_identifier
  }
}

resource "aws_s3_bucket_versioning" "upload_diagramas_versioning" {
  bucket = aws_s3_bucket.upload_diagramas.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "upload_diagramas_encryption" {
  bucket = aws_s3_bucket.upload_diagramas.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "upload_diagramas_public_access_block" {
  bucket = aws_s3_bucket.upload_diagramas.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
