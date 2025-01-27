provider "aws" {
  region = "us-east-1" # Change to your desired AWS region
}

*/ # Backend configuration to store state in S3 and enable DynamoDB table for state locking
#terraform {
 # backend "s3" {
 #   bucket = "s3-bucket-name"    # Replace with your S3 bucket name
 #   key    = "path/to/terraform.tfstate"  # Specify the path where state file will be stored
 #   region = "us-east-1"  # Ensure this matches your provider's region
 #   encrypt = true  # Optional: Encrypt the state file in S3
 #   dynamodb_table = "dynamodb-lock-table"  # Replace with your DynamoDB lock table name
 #   acl    = "bucket-owner-full-control"  # Set appropriate ACL for your use case
  }/* 
