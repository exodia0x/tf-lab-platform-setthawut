############## VNET ##############
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-test-poc-01"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location
  address_space       = ["192.10.0.0/24"]
}
##################################




############## Subnet ##############
// snet-test-poc-01
resource "azurerm_subnet" "snet-test-poc-01" {
  name                 = "snet-test-poc-01"
  resource_group_name  = azurerm_resource_group.Resource_Group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.10.0.0/27"]

  delegation {
    name = "databricks-pub"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

// snet-test-poc-02
resource "azurerm_subnet" "snet-test-poc-02" {
  name                 = "snet-test-poc-02"
  resource_group_name  = azurerm_resource_group.Resource_Group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.10.0.32/27"]

  delegation {
    name = "databricks-pub"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

// snet-test-poc-03
resource "azurerm_subnet" "snet-test-poc-03" {
  name                 = "snet-test-poc-03"
  resource_group_name  = azurerm_resource_group.Resource_Group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.10.0.64/27"]
}
##################################




############## Link to Private DNS ##############
// privatedns_file
resource "azurerm_private_dns_zone_virtual_network_link" "privatedns_file" {

  name                  = "link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  private_dns_zone_name = azurerm_private_dns_zone.privatedns_st_file.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [azurerm_virtual_network.vnet, azurerm_private_dns_zone.privatedns_st_file]
}

// privatedns_blob
resource "azurerm_private_dns_zone_virtual_network_link" "privatedns_blob" {

  name                  = "link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  private_dns_zone_name = azurerm_private_dns_zone.privatedns_st_blob.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [azurerm_virtual_network.vnet, azurerm_private_dns_zone.privatedns_st_blob]
}

// privatedns_adlsgen-dfs
resource "azurerm_private_dns_zone_virtual_network_link" "privatedns_adlsgen2" {

  name                  = "link-${azurerm_virtual_network.vnet.name}"
  resource_group_name   = azurerm_resource_group.Resource_Group.name
  private_dns_zone_name = azurerm_private_dns_zone.privatedns_st_adlsgen2.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [azurerm_virtual_network.vnet, azurerm_private_dns_zone.privatedns_st_adlsgen2]
}
##################################