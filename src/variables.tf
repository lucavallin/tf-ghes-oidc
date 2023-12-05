variable "GHES_INSTANCE_NAME" {
  type        = string
  description = "Name of the GHES instance (e.g. my-ghes-instance)"
}

variable "GHES_URL" {
  type        = string
  description = "URL of the GHES instance without 'https://' (e.g. my-ghes-instance.com)"
}

variable "AZURE_SUBSCRIPTION_ID" {
  type        = string
  description = "ID of the Azure subscription to use"
}

variable "GCP_PROJECT_ID" {
  type        = string
  description = "ID of the Google Cloud project to use"
}
