# GitHub Enterprise Server URL
output "ghes_settings_url" {
  value = "https://${local.ghes_url}:8443"
}

# Azure Configuration for OIDC
output "azure_tenant_id" {
  value = data.azuread_client_config.this.tenant_id
}
output "azure_client_id" {
  value = azuread_application.this.client_id
}
output "azure_storage_account_name" {
  value = azurerm_storage_account.this.name
}
output "azure_blob_endpoint_suffix" {
  value = local.azure_blob_endpoint_suffix
}

# AWS Configuration for OIDC
output "aws_s3_bucket" {
  value = aws_s3_bucket.this.bucket
}
output "aws_role" {
  value = ""
}
output "aws_region" {
  value = data.aws_region.this.name
}

# Google Cloud Configuration for OIDC
output "gcp_service_url" {
  value = "https://${local.gcp_service_url}"
}

output "gcp_bucket_name" {
  value = google_storage_bucket.this.name
}

output "gcp_workload_identity_provider_id" {
  value = google_iam_workload_identity_pool_provider.this.name
}

output "gcp_service_account" {
  value = google_service_account.this.email
}
