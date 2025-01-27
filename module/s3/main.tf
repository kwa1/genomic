resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  dynamic "versioning" {
    for_each = var.enable_versioning ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.enable_encryption ? [1] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }
  }

  tags = var.tags
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}
