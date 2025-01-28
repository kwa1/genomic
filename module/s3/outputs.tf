output "s3_buckets_names" {
  description = "The list of S3 bucket names"
  value       = aws_s3_bucket.this_logging[*].bucket
}

output "logging_configuration" {
  description = "The S3 logging configuration"
  value       = aws_s3_bucket.this_logging[*].logging
}

output "versioning_configuration" {
  description = "The versioning configuration for the S3 buckets"
  value       = aws_s3_bucket.this_versioning[*].versioning
}
