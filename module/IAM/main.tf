# Create IAM Policy for User A (Read/Write to Bucket A)
resource "aws_iam_policy" "user_a_s3_policy" {
  name        = "UserA_S3_ReadWrite_Policy"
  description = "Read/Write access to Bucket A"

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
          "arn:aws:s3:::bucket-a", 
          "arn:aws:s3:::bucket-a/*"
        ]
      }
    ]
  })
}
# Create IAM Policy for User B (ReadOnly to Bucket B)

resource "aws_iam_policy" "user_b_s3_policy" {
  name        = "UserB_S3_ReadOnly_Policy"
  description = "Read-only access to Bucket B"

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
          "arn:aws:s3:::bucket-b", 
          "arn:aws:s3:::bucket-b/*"
        ]
      }
    ]
  })
}
# create IAM USERS
resource "aws_iam_user" "user_a" {
  name = "UserA"
}

resource "aws_iam_user" "user_b" {
  name = "UserB"
}
# Attach policy to users
resource "aws_iam_policy_attachment" "user_a_policy_attachment" {
  name       = "UserA_S3_ReadWrite_Attachment"
  users      = [aws_iam_user.user_a.name]
  policy_arn = aws_iam_policy.user_a_s3_policy.arn
}

resource "aws_iam_policy_attachment" "user_b_policy_attachment" {
  name       = "UserB_S3_ReadOnly_Attachment"
  users      = [aws_iam_user.user_b.name]
  policy_arn = aws_iam_policy.user_b_s3_policy.arn
}
