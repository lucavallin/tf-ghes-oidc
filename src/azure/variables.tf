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
