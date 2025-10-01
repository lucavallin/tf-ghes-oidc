terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.42.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.11.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
