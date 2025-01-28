output "s3_bucket_names" {
  value = module.s3.bucket_names
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}
output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_role" {
  description = "The IAM role for the Lambda function"
  value       = module.lambda.lambda_role
}
