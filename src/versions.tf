terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.28.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}
