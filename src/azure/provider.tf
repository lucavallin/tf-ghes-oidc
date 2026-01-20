provider "azurerm" {
  features {}
  subscription_id = local.azure_subscription_id
}
provider "azuread" {}
provider "random" {}
