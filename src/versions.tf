terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.58.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.7.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}
