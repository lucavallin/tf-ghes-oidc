locals {
  gcp_service_url = "storage.googleapis.com"
}

# GitHub Enterprise Server URL
output "ghes_settings_url" {
  value = "https://${local.ghes_url}:8443"
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
