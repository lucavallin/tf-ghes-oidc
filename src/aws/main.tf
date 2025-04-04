locals {
  ghes_name       = var.GHES_NAME
  ghes_hostname   = var.GHES_HOSTNAME
  oidc_issuer_uri = "https://${local.ghes_hostname}/_services/token"

  # AWS
  aws_region          = var.AWS_REGION
  aws_sts_endpoint    = var.AWS_STS_ENDPOINT
  aws_oidc_thumbprint = var.AWS_OIDC_THUMBPRINT
}

resource "random_string" "long" {
  length  = 24
  lower   = true
  numeric = true
  special = false
  upper   = false
}

# AWS Region for GHES configuration
data "aws_region" "this" {}

# S3 Bucket for Actions data
resource "aws_s3_bucket" "this" {
  bucket = random_string.long.result
}

# OIDC provider for GHES
resource "aws_iam_openid_connect_provider" "this" {
  url             = local.oidc_issuer_uri
  client_id_list  = [local.aws_sts_endpoint]
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
            "${aws_iam_openid_connect_provider.this.url}:aud" = local.aws_sts_endpoint
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
