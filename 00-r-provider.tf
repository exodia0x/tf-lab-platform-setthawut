terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.70.0"
    }
  }
  # backend "azurerm" {
  #     resource_group_name  = "poc-tfstate"
  #     storage_account_name = "st-poc-tfstate"
  #     container_name       = "tfstate"
  #     key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  subscription_id = "<SubscriptionID Test01>"
  tenant_id       = "<TenantID Test01>"
  features {}
}

provider "databricks" {
  host = azurerm_databricks_workspace.databricks-adbtestprovision.workspace_url
}