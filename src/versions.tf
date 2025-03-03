terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}
