output "azure_tenant_id" {
  value = data.azuread_client_config.this.tenant_id
}
output "azure_client_id" {
  value = azuread_application.this.client_id
}
output "azure_storage_account_name" {
  value = azurerm_storage_account.this.name
}
output "azure_blob_endpoint_suffix" {
  value = local.azure_blob_endpoint_suffix
}
