locals {
  gcp_project_id = var.GCP_PROJECT_ID
  ghes_hostname  = var.GHES_HOSTNAME
  ghes_url       = var.GHES_URL
}

data "google_project" "this" {
  project_id = local.gcp_project_id
}

# These APIs must be enabled for OIDC
resource "google_project_service" "storage" {
  project = data.google_project.this.project_id
  service = "storage.googleapis.com"
}
resource "google_project_service" "iam_credentials" {
  project = data.google_project.this.project_id
  service = "iamcredentials.googleapis.com"
}

# Setup Workload Identity Pool and Provider
resource "google_iam_workload_identity_pool" "this" {
  project                   = data.google_project.this.project_id
  workload_identity_pool_id = "wip-ghes"
  description               = "Identity Pool for GHES instance ${local.ghes_hostname}."
}

resource "google_iam_workload_identity_pool_provider" "this" {
  project                            = data.google_project.this.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = "wipp-ghes-oidc"
  description                        = "Identity Pool Provider for OIDC on GHES instance ${local.ghes_hostname}."

  attribute_condition = "google.subject == \"${local.ghes_url}\""
  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }

  oidc {
    issuer_uri = "https://${local.ghes_url}/_services/token"
  }
}

# Create service account and assign required permissions
resource "google_service_account" "this" {
  project      = data.google_project.this.project_id
  account_id   = "sa-${substr(local.ghes_hostname, 0, 20)}-oidc"
  display_name = "Service Account for OIDC on GHES"
  description  = "Service Account for OIDC on GHES instance ${local.ghes_hostname}."
}

resource "google_project_iam_binding" "sa_storage" {
  project = data.google_project.this.project_id
  role    = "roles/storage.objectAdmin"
  members = ["serviceAccount:${google_service_account.this.email}"]
}

resource "google_project_iam_binding" "sa_token_creator" {
  project = data.google_project.this.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_service_account.this.email}"]
}

# Grant the Service Account access to the Workload Identity Pool
resource "google_service_account_iam_binding" "sa_workload_identity" {
  service_account_id = google_service_account.this.id
  role               = "roles/iam.workloadIdentityUser"
  members            = ["principal://iam.googleapis.com/${google_iam_workload_identity_pool.this.name}/subject/${local.ghes_url}"]
}

# Storage bucket for Actions data
resource "google_storage_bucket" "this" {
  project = data.google_project.this.project_id
  name    = "sb-${local.ghes_hostname}"

  location                    = "EUROPE-WEST4"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
