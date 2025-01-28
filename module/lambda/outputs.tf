output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "lambda_role" {
  description = "The IAM role for the Lambda function"
  value       = aws_iam_role.lambda_role.arn
}
