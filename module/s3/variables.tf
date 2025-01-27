variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "enable_versioning" {
  type        = bool
  description = "Enable versioning for the bucket"
}

variable "enable_encryption" {
  type        = bool
  description = "Enable encryption for the bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the bucket"
}
