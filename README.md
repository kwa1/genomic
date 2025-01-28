Terraform AWS Infrastructure
This project contains a Terraform configuration for provisioning an AWS Lambda function with an associated IAM role, an S3 bucket for event-driven file processing, and CloudWatch logging. The Lambda function is triggered by object creation events in the S3 bucket.

Table of Contents
Overview
Modules
S3 Module
Lambda Module
Usage
Variables
Outputs
Notes
Overview
This Terraform project provisions the following AWS resources:

S3 Buckets: Two S3 buckets are created. One bucket is used as a source bucket to trigger events for the Lambda function, and the second bucket (destination bucket) will be used for further processing or storage.

Lambda Function: A Python-based Lambda function is created and triggered by events in the S3 source bucket. It reads from and writes to the S3 buckets as per the provided configuration.

IAM Roles and Policies: The Lambda function is assigned an IAM role with specific permissions to access the S3 buckets and write logs to CloudWatch.

CloudWatch Logs: CloudWatch log groups are created for monitoring Lambda execution.

S3 Event Notifications: S3 bucket notifications are set up to trigger the Lambda function on object creation events.

Modules
This project is divided into two primary modules:

S3 Module
This module is responsible for provisioning the S3 buckets, including the following configurations:

Buckets Creation: Creates two S3 buckets with the specified ACL and region.
Logging: Enables access logging on the buckets, storing logs in a designated log bucket.
Versioning: Optionally enables versioning on the S3 buckets.
ACL & Encryption: Configures bucket ACL and applies encryption using AWS KMS for the bucket's content.
The configuration is located in the s3 directory.

Lambda Module
This module is responsible for provisioning an AWS Lambda function, the IAM role required by the function, and the event-driven processing. The following configurations are included:

Lambda Function: Creates a Python-based Lambda function that processes files triggered by S3 events.
IAM Role & Policy: Defines an IAM role with permissions for accessing the source and destination S3 buckets.
S3 Event Notification: Sets up S3 event notifications to trigger the Lambda function when new objects are created in the source bucket.
CloudWatch Logs: Creates CloudWatch log groups for Lambda execution logs.
The configuration is located in the lambda directory.

Usage
To deploy the infrastructure using Terraform:

Clone the repository:

bash
Copy
Edit
git clone <repository_url>
cd <repository_directory>
Initialize Terraform:

Initialize the Terraform configuration:

bash
Copy
Edit
terraform init
Apply the Terraform configuration:

To apply the configuration and create the resources, use the following command:

bash
Copy
Edit
terraform apply
You will be prompted to review the changes that will be made to your AWS account. Type yes to proceed with the deployment.

Destroy the resources:

To destroy the created resources (and avoid ongoing costs), run:

bash
Copy
Edit
terraform destroy
Variables
The following variables are used to customize the infrastructure:

Global Variables (used in main.tf):
lambda_function_name: The name of the Lambda function.
object_key: The S3 key for the Lambda ZIP file.
source_path: The local path to the Lambda ZIP file.
environment_variables: Environment variables for the Lambda function.
filter_prefix: Prefix for triggering the Lambda via S3 events.
filter_suffix: Suffix for triggering the Lambda via S3 events.
bucket_names: List of S3 bucket names to be created.
bucket_acl: ACL (Access Control List) for the S3 buckets (default: "private").
bucket_region: The AWS region where the S3 buckets are created.
prevent_destroy: If set to true, it prevents the S3 buckets from being destroyed.
tags: Tags to apply to all resources.
Outputs
The following output values will be displayed after applying the Terraform configuration:

s3_bucket_names: The names of the S3 buckets.
lambda_function_name: The name of the Lambda function.
lambda_function_arn: The ARN of the Lambda function.
lambda_role: The ARN of the IAM role for the Lambda function.
lambda_s3_notification: The ID of the S3 bucket notification.
Notes
Ensure that your AWS credentials are configured properly to allow Terraform to create and manage resources.
The lambda.zip file must be available at the specified source_path. It will be uploaded to the S3 bucket specified by object_key.
The Lambda function is triggered by object creation in the source S3 bucket. Ensure that your object prefix and suffix filters are correctly configured to match your use case.
If the prevent_destroy variable is set to true, you will not be able to destroy the S3 buckets without modifying this configuration.
License
This project is licensed under the MIT License - see the LICENSE file for details.

End of README
This README.md provides a comprehensive description of your Terraform infrastructure, explaining how to configure and use each module, along with the variables and outputs for easy understanding and deployment.
