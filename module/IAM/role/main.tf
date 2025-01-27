# My prefered method to use IAM role instead of IAM-User
# Reasons- Temporary Access/ Assume role, cross-accounts/can be reassign to multiple users.

# IAM Policy for read/write access (e.g., for UserA)
resource "aws_iam_policy" "read_write_policy" {
  name        = "read_write_s3_policy"
  description = "S3 Read/Write Access Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.users["UserA"].bucket_name}",
          "arn:aws:s3:::${var.users["UserA"].bucket_name}/*"
        ]
      }
    ]
  })
}

# IAM Policy for read-only access (e.g., for UserB)
resource "aws_iam_policy" "read_only_policy" {
  name        = "read_only_s3_policy"
  description = "S3 Read-Only Access Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.users["UserB"].bucket_name}",
          "arn:aws:s3:::${var.users["UserB"].bucket_name}/*"
        ]
      }
    ]
  })
}

# Dynamically create IAM Roles
resource "aws_iam_role" "user_role" {
  for_each = var.users

  name = each.key

  # Attach the environment tag to the IAM role
  tags = {
    Environment = each.value.environment
  }

  # Trust policy to allow EC2 or other services to assume this role (can be customized further)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = "*"  # Adjust as needed for specific services or accounts
        }
      }
    ]
  })
}

# Attach the appropriate IAM policy to each role based on access type
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  for_each = var.users

  role = aws_iam_role.user_role[each.key].name

  # Attach the correct policy depending on the access type
  policy_arn = each.value.access_type == "read_write" ? aws_iam_policy.read_write_policy.arn : aws_iam_policy.read_only_policy.arn
}

