# AWS Region for GHES configuration
data "aws_region" "this" {}

# S3 Bucket for Actions data
resource "aws_s3_bucket" "this" {
  bucket = random_string.long.result
}

# OIDC provider for GHES
resource "aws_iam_openid_connect_provider" "this" {
  url             = local.oidc_issuer_uri
  client_id_list  = [local.aws_oidc_client_id]
  thumbprint_list = [local.aws_oidc_thumbprint]
}

# Roles & Policies for OIDC
resource "aws_iam_role" "this" {
  name = local.ghes_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.this.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${aws_iam_openid_connect_provider.this.url}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
