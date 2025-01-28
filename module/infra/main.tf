# Root Terraform Configuration (infra/main.tf)

module "s3" {
  source         = "./s3"
  bucket_names   = var.bucket_names
  bucket_acl     = var.bucket_acl
  bucket_region  = var.bucket_region
  prevent_destroy = var.prevent_destroy
  tags           = var.tags
}

module "lambda" {
  source               = "./lambda"
  function_name        = var.lambda_function_name
  source_bucket_name   = module.s3.bucket_names[0]
  destination_bucket_name = "bucket-b-name"
  object_key           = var.object_key
  source_path          = var.source_path
  environment_variables = var.environment_variables
  filter_prefix        = var.filter_prefix
  filter_suffix        = var.filter_suffix
}
