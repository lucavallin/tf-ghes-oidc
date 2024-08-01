locals {
  ghes_name       = var.GHES_NAME
  ghes_hostname   = var.GHES_HOSTNAME
  oidc_issuer_uri = "https://${local.ghes_hostname}/_services/token"

  azure_subscription_id                  = var.AZURE_SUBSCRIPTION_ID
  azure_region                           = var.AZURE_REGION
  azure_storage_account_tier             = var.AZURE_STORAGE_ACCOUNT_TIER
  azure_storage_account_replication_type = var.AZURE_STORAGE_ACCOUNT_REPLICATION_TYPE
  azure_blob_endpoint_suffix             = "core.windows.net"

  aws_region          = var.AWS_REGION
  aws_sts_endpoint    = var.AWS_STS_ENDPOINT
  aws_oidc_thumbprint = var.AWS_OIDC_THUMBPRINT

  gcp_project_id  = var.GCP_PROJECT_ID
  gcp_region      = var.GCP_REGION
  gcp_service_url = "storage.googleapis.com"
}

resource "random_string" "long" {
  length  = 24
  lower   = true
  numeric = true
  special = false
  upper   = false
}

resource "random_string" "short" {
  length  = 8
  lower   = true
  numeric = true
  special = false
  upper   = false
}
