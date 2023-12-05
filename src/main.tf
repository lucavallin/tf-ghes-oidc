locals {
  ghes_instance_name = var.GHES_INSTANCE_NAME
  ghes_url           = var.GHES_URL
  issuer_uri         = "https://${local.ghes_url}/_services/token"

  azure_blob_endpoint_suffix = "core.windows.net"

  gcp_project_id  = var.GCP_PROJECT_ID
  gcp_service_url = "storage.googleapis.com"
}
