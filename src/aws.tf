# AWS Region for GHES configuration
data "aws_region" "this" {}

# S3 Bucket for Actions data
resource "aws_s3_bucket" "this" {
  bucket = random_string.unique_name.result
}

# OIDC provider for GHES
resource "aws_iam_openid_connect_provider" "this" {
  url             = local.oidc_issuer_uri
  client_id_list  = [local.aws_oidc_client_id]
  thumbprint_list = [local.aws_oidc_thumbprint]
}
