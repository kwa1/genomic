variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "object_key" {
  description = "The key for the Lambda ZIP file in S3"
  type        = string
}

variable "source_path" {
  description = "The local path to the Lambda ZIP file"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for Lambda function"
  type        = map(string)
  default     = {}
}

variable "filter_prefix" {
  description = "Prefix for S3 event trigger"
  type        = string
  default     = ""
}

variable "filter_suffix" {
  description = "Suffix for S3 event trigger"
  type        = string
  default     = ""
}

variable "bucket_names" {
  description = "List of S3 bucket names"
  type = list(object({
    bucket_name = string
  }))
  default = [
    { bucket_name = "bucket-a" },
    { bucket_name = "bucket-b" }
  ]
}

variable "bucket_acl" {
  description = "ACL for the bucket"
  type        = string
  default     = "private"
}

variable "bucket_region" {
  description = "AWS region for the bucket"
  type        = string
  default     = "us-east-1"
}

variable "prevent_destroy" {
  description = "Prevent destroying resources"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default     = {}
}
