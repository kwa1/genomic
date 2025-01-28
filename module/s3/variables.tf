variable "bucket_names" {
  description = "List of S3 bucket names"
  type = list(string)
}

variable "bucket_acl" {
  description = "ACL for the S3 bucket"
  type        = string
  default     = "private"
}

variable "bucket_region" {
  description = "AWS region for the bucket"
  type        = string
  default     = "us-east-1"
}

variable "logs_bucket_name" {
  description = "Name of the bucket where access logs are stored"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
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
