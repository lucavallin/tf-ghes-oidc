variable "GHES_NAME" {
  type        = string
  description = "GHES: Name of the instance (e.g. my-ghes-instance)"
}

variable "GHES_HOSTNAME" {
  type        = string
  description = "GHES: Hostname of the instance without 'https://' (e.g. my-ghes-instance.com)"
}

variable "GCP_PROJECT_ID" {
  type        = string
  description = "Google Cloud: ID of the Project to use"
}

variable "GCP_REGION" {
  type        = string
  description = "Google Cloud: Region for OIDC Resources"
  default     = "EUROPE-WEST4"
}
