terraform {
  # This backend is the state storage for terraform. It is important to keep this account secure (limited access) 
  # as it contains all the details about the deployments. DO NOT manually modify or delete the state file!
  backend "azurerm" {
    resource_group_name  = "tf-deploy-state"
    storage_account_name = ""
    container_name       = ""
    key                  = "tfstate.dat"
  }


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.76.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}