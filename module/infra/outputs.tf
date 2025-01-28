output "s3_bucket_names" {
  value = module.s3.bucket_names
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}
