output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "lambda_role" {
  description = "The IAM role for the Lambda function"
  value       = aws_iam_role.lambda_role.arn
}

output "lambda_s3_notification" {
  description = "The S3 bucket notification for Lambda"
  value       = aws_s3_bucket_notification.lambda_trigger.id
}
