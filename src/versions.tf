terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}
