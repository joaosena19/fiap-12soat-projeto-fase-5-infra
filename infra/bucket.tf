resource "aws_s3_bucket" "upload_diagramas" {
  bucket = var.upload_s3_bucket_name

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
