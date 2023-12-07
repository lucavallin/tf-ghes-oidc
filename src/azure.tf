data "azurerm_subscription" "this" {}

data "azuread_client_config" "this" {}

# Resource group to contain resources for Actions on GHES with OIDC
resource "azurerm_resource_group" "this" {
  name     = local.ghes_name
  location = local.azure_region
}

# Storage Account for Actions data
resource "azurerm_storage_account" "this" {
  name                     = random_string.unique_name.result
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = local.azure_storage_account_tier
  account_replication_type = local.azure_storage_account_replication_type
}

# Azure Active Directory (AAD) application for OIDC
resource "azuread_application" "this" {
  display_name = local.ghes_name
}

resource "azuread_application_federated_identity_credential" "this" {
  application_id = azuread_application.this.id
  display_name   = local.ghes_name
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = local.oidc_issuer_uri
  subject        = local.ghes_hostname
}

# Grant the AAD Application access to the Storage Account
resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_subscription.this.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_service_principal.this.id
}
