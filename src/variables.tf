variable "GHES_NAME" {
  type        = string
  description = "GHES: Name of the instance (e.g. my-ghes-instance)"
}

variable "GHES_HOSTNAME" {
  type        = string
  description = "GHES: Hostname of the instance without 'https://' (e.g. my-ghes-instance.com)"
}

variable "AZURE_SUBSCRIPTION_ID" {
  type        = string
  description = "Azure: ID of the Subscription to use"
}

variable "AZURE_REGION" {
  type        = string
  description = "Azure: Region for the Storage Account"
  default     = "West Europe"
}

variable "AZURE_STORAGE_ACCOUNT_TIER" {
  type        = string
  description = "Azure: Tier for the Storage Account"
  default     = "Standard"
}

variable "AZURE_STORAGE_ACCOUNT_REPLICATION_TYPE" {
  type        = string
  description = "Azure: Replication Type for Storage Account"
  default     = "LRS"
}

variable "AWS_REGION" {
  type        = string
  description = "AWS: Region for OIDC Resources"
  default     = "eu-north-1"
}

variable "AWS_OIDC_THUMBPRINT" {
  type        = string
  description = "AWS: Thumbprint of the GHES Instance for OIDC"
}

variable "AWS_STS_ENDPOINT" {
  type        = string
  description = "AWS: URL of the STS endpoint to use as audience for OIDC"
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
