terraform {
  required_version = ">=1.4.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "RG-WHATEVER-NAME-YOU-CAME-UP-WITH-GOES-HERE"
    storage_account_name = "FILL-IN-STORAGE-ACCOUNT-NAME-HERE"
    container_name       = "tfstates"
    key                  = "caddy-waf-configuration.tfstate"   // MUST be unique in this storage!
  }
}

provider "azurerm" {
  features {}
  subscription_id = "YOUR-PROVIDER-ID-GOES-HERE"
}