terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.26.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.36.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
    custom = {
      source = "google.com/google-alpha/google-private"
      version = "0.0.324"
    }
  }
  required_version = "~> 0.14"

}

provider "azurerm" {
  features {}
}