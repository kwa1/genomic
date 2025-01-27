variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "runtime" {
  type        = string
  description = "Runtime for the Lambda function"
}

variable "handler" {
  type        = string
  description = "Handler for the Lambda function"
}

variable "role_arn" {
  type        = string
  description = "ARN of the execution role"
}

variable "source_code_path" {
  type        = string
  description = "Path to the Lambda source code ZIP file"
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the Lambda function"
}
