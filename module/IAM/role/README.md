# Dynamic IAM Role Creation Using Terraform

---

## Overview
This Terraform module dynamically creates IAM roles and policies to provide secure, fine-grained access to AWS S3 buckets. The configuration uses a user-defined map of roles to determine the appropriate access level (`read_write` or `read_only`) for each S3 bucket.

---

## Features
- **Dynamic Role and Policy Creation**: IAM roles and policies are dynamically generated based on the user-defined configuration.
- **Granular S3 Access Control**: Policies provide specific permissions for `read_write` and `read_only` access.
- **Scalability**: Easily add new roles and policies by updating the configuration.
- **Security Best Practices**: Follows AWS Well-Architected Framework principles, ensuring least privilege access and role-based access control.

---

## Usage

### 1. Clone the Repository
Clone or download the Terraform configuration files.

```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. Configure Your Roles
Update the `users` variable in `variables.tf` to define the roles, access levels, and associated S3 buckets.

Example:
```hcl
variable "users" {
  default = {
    "UserA" = {
      access_type = "read_write"
      environment = "dev"
      bucket_name = "bucket-a"
    },
    "UserB" = {
      access_type = "read_only"
      environment = "prod"
      bucket_name = "bucket-b"
    }
  }
}
```

### 3. Initialize Terraform
Initialize Terraform to download the required providers.

```bash
terraform init
```

### 4. Preview Changes
Preview the changes that Terraform will apply to your AWS environment.

```bash
terraform plan
```

### 5. Apply Changes
Create the IAM roles and policies.

```bash
terraform apply
```

### 6. Validate Resources
- Log in to the **AWS Management Console** and check the IAM roles and attached policies.
- Verify that the roles have the correct access to the specified S3 buckets.

---

## Adding New Roles
To add a new role, update the `users` map in `main.tf` with the new role details:

```hcl
"UserC" = {
  access_type = "read_write"
  environment = "test"
  bucket_name = "bucket-c"
}
```

Re-run Terraform to apply the changes:

```bash
terraform apply
```

---

## IAM Policies
The module creates and attaches the following policies:

- **Read/Write Policy**: Grants `GetObject`, `PutObject`, `ListBucket`, and `DeleteObject` permissions.
- **Read-Only Policy**: Grants `GetObject` and `ListBucket` permissions.

These policies are dynamically attached to the IAM roles based on the `access_type` defined in the `users` map.

---

## Testing
You can test the roles using the AWS CLI:

1. Assume the role:
   ```bash
   aws sts assume-role --role-arn "arn:aws:iam::<account_id>:role/<RoleName>" --role-session-name test-session
   ```

2. Use the returned temporary credentials to test access to the S3 bucket:
   ```bash
   aws s3 ls s3://<bucket-name>
   ```

---

## Best Practices
- Use separate Terraform workspaces or modules for managing production and development environments.
- Regularly audit IAM roles and policies for compliance with the principle of least privilege.
- Enable CloudTrail logging to monitor IAM activity.

---

## Requirements
- **Terraform Version**: `>= 1.0.0`
- **AWS Provider**: `>= 4.0.0`
- An AWS account with appropriate permissions to create IAM roles, policies, and manage S3.

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
