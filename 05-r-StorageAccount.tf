resource "azurerm_storage_account" "sttestprovision" {
  name                             = "sttestprovision"
  resource_group_name              = azurerm_resource_group.Resource_Group.name
  location                         = azurerm_resource_group.Resource_Group.location
  account_tier                     = "Standard"
  access_tier                      = "Hot"
  account_replication_type         = "LRS"
  cross_tenant_replication_enabled = false

  // Enable ADLs Gen2
  is_hns_enabled = true

  // Security
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
  default_to_oauth_authentication = false
  min_tls_version                 = "TLS1_2"
  sftp_enabled                    = false
  nfsv3_enabled                   = false

  // Network
  public_network_access_enabled = false
  routing {
    choice = "MicrosoftRouting"
  }
  network_rules {
    default_action = "Deny"
  }

  // Blob Properties
  blob_properties {
    delete_retention_policy {
      days                     = 7
      permanent_delete_enabled = false
    }
    container_delete_retention_policy {
      days = 7
    }
  }
}


