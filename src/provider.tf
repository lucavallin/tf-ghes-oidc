provider "azurerm" {
  features {}
  subscription_id = local.azure_subscription_id
}
provider "azuread" {}
provider "aws" {}
provider "google" {
  project = local.gcp_project_id
}
