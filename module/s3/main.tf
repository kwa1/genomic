
# Creating S3 Buckets
resource "aws_s3_bucket" "this" {
  for_each = { for idx, bucket in var.bucket_names : bucket.bucket_name => bucket }

  bucket = each.value.bucket_name
  acl    = var.bucket_acl
  region = var.bucket_region

  tags = var.tags
}

resource "aws_s3_bucket" "this_logging" {
  count = length(var.bucket_names)

  bucket = var.bucket_names[count.index].bucket_name
  acl    = var.bucket_acl
  region = var.bucket_region

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }

  logging {
    target_bucket = var.logs_bucket_name
    target_prefix = "logs/${var.bucket_names[count.index].bucket_name}/"
  }

  server_side_encryption_configuration {
    rule {
      actions = ["AES256"] 

      apply_server_side_encryption_by_default {
        sse_algorithm      = "aws:kms"
        kms_master_key_id  = "alias/aws/s3"
      }
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket" "this_versioning" {
  count = length(var.bucket_names)

  bucket = var.bucket_names[count.index].bucket_name
  acl    = var.bucket_acl
  region = var.bucket_region

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }

  dynamic "versioning" {
    for_each = var.enable_versioning ? [1] : []
    content {
      enabled = true
    }
  }

  tags = var.tags
}
