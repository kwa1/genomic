variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "source_bucket_name" {
  description = "The source S3 bucket name"
  type        = string
}

variable "destination_bucket_name" {
  description = "The destination S3 bucket name"
  type        = string
}

variable "object_key" {
  description = "The object key in S3"
  type        = string
}

variable "source_path" {
  description = "The source path for the object"
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
  default     = ".jpg"
}
