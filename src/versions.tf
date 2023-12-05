terraform {
  required_version = ">= 1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.83.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "5.7.0"
    }
  }
}
