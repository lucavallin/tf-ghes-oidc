data "google_project" "this" {
  project_id = local.gcp_project_id
}

# These APIs must be enabled for OIDC
resource "google_project_service" "storage" {
  service = "storage.googleapis.com"
}
resource "google_project_service" "iam_credentials" {
  service = "iamcredentials.googleapis.com"
}

# Setup Workload Identity Pool and Provider
resource "google_iam_workload_identity_pool" "this" {
  workload_identity_pool_id = local.ghes_instance_name
}

resource "google_iam_workload_identity_pool_provider" "this" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = local.ghes_instance_name

  attribute_condition = "google.subject == \"${local.ghes_url}\""
  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }

  oidc {
    issuer_uri = local.oidc_issuer_uri
  }
}

# Create service account and assign required permissions
resource "google_service_account" "this" {
  account_id = substr(local.ghes_instance_name, 0, 28)
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
  name     = random_string.unique_name.result
  location = local.gcp_region
}
