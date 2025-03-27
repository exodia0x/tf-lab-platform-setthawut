############## Private DNS Zone for StorageAccount ##############
// privatedns_st_file
resource "azurerm_private_dns_zone" "privatedns_st_file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.Resource_Group.name
}

// privatedns_st_blob
resource "azurerm_private_dns_zone" "privatedns_st_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.Resource_Group.name
}

// privatedns_st_adlsgen2-dfs
resource "azurerm_private_dns_zone" "privatedns_st_adlsgen2" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = azurerm_resource_group.Resource_Group.name
}
##################################




############## Private Endpoint StorageAccount ##############
// File
resource "azurerm_private_endpoint" "pe-sttestprovision-file" {
  name                = "pe-sttestprovision-file"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location
  subnet_id           = azurerm_subnet.snet-test-poc-03.id

  private_service_connection {
    name                           = "pe-sttestprovision-file"
    private_connection_resource_id = azurerm_storage_account.sttestprovision.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["${azurerm_private_dns_zone.privatedns_st_file.id}"]
  }

  depends_on = [azurerm_private_dns_zone.privatedns_st_file, azurerm_private_dns_zone_virtual_network_link.privatedns_file]
}

// Blob
resource "azurerm_private_endpoint" "pe-sttestprovision-blob" {
  name                = "pe-sttestprovision-blob"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location
  subnet_id           = azurerm_subnet.snet-test-poc-03.id

  private_service_connection {
    name                           = "pe-sttestprovision-blob"
    private_connection_resource_id = azurerm_storage_account.sttestprovision.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["${azurerm_private_dns_zone.privatedns_st_blob.id}"]
  }

  depends_on = [azurerm_private_dns_zone.privatedns_st_blob, azurerm_private_dns_zone_virtual_network_link.privatedns_blob]
}

// ADLs Gen2 - DFS
resource "azurerm_private_endpoint" "pe-sttestprovision-adlsgen2" {
  name                = "pe-sttestprovision-dfs"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location
  subnet_id           = azurerm_subnet.snet-test-poc-03.id

  private_service_connection {
    name                           = "pe-sttestprovision-dfs"
    private_connection_resource_id = azurerm_storage_account.sttestprovision.id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["${azurerm_private_dns_zone.privatedns_st_adlsgen2.id}"]
  }

  depends_on = [azurerm_private_dns_zone.privatedns_st_adlsgen2, azurerm_private_dns_zone_virtual_network_link.privatedns_adlsgen2]
}
##################################