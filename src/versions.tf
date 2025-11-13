terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
