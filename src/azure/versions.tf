terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}
