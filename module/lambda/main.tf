resource "aws_lambda_function" "lambda" {
  function_name        = var.function_name
  runtime              = var.runtime
  handler              = var.handler
  role                 = var.role_arn
  filename             = var.source_code_path
  source_code_hash     = filebase64sha256(var.source_code_path)

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}
