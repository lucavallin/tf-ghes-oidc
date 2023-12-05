# The hostname of the GHES instance (e.g. my-ghes-instance)
variable "GHES_HOSTNAME" {
  type = string
}

# The URL of the GHES instance (e.g. my-ghes-instance.com)
variable "GHES_URL" {
  type = string
}

# ID of the Google Cloud project to use
variable "GCP_PROJECT_ID" {
  type = string
}
