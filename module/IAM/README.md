# Terraform Configuration for AWS IAM Policies and Users

## Overview

This Terraform configuration creates and manages the following AWS resources:
- Two IAM users (`UserA` and `UserB`).
- Two IAM policies:
  - **User A Policy**: Grants read/write access to S3 Bucket `bucket-a`.
  - **User B Policy**: Grants read-only access to S3 Bucket `bucket-b`.
- Policy attachments to associate the policies with respective users.

## Prerequisites

- AWS CLI installed and configured with appropriate credentials.
- Terraform CLI installed.
##- An S3 bucket and a DynamoDB table for storing Terraform state 

## Resources Created

### IAM Policies
- **User A S3 Policy**:
  - Grants `s3:GetObject`, `s3:PutObject`, `s3:ListBucket`, and `s3:DeleteObject` actions on `bucket-a`.
- **User B S3 Policy**:
  - Grants `s3:GetObject` and `s3:ListBucket` actions on `bucket-b`.

### IAM Users
- `UserA`
- `UserB`

### IAM Policy Attachments
- Attaches `UserA_S3_ReadWrite_Policy` to `UserA`.
- Attaches `UserB_S3_ReadOnly_Policy` to `UserB`.

## Usage

1. **Update Provider Configuration**:
   Replace the region in the `provider "aws"` block with your desired AWS region.

2. **Optional: Configure Backend**:
  ## Uncomment and update the backend configuration in the `terraform` block to enable state storage in an S3 bucket with state locking via DynamoDB.

3. **Initialize Terraform**:
   ```bash
   terraform init
