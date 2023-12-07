provider "azurerm" {
  features {}
  subscription_id = local.azure_subscription_id
}
provider "azuread" {}
provider "aws" {
  region                   = local.aws_region
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}
provider "google" {
  project = local.gcp_project_id
}
provider "random" {}
