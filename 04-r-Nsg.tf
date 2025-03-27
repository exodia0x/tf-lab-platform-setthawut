############## NSG snet-test-poc-01 ##############
resource "azurerm_network_security_group" "nsg-snet-test-poc-01" {
  name                = "nsg-snet-test-poc-01"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location

  security_rule {
    name                       = "AllowSubnetInBound"
    priority                   = 4094
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["192.10.0.0/27"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyOtherSubnetsInBound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  lifecycle {
    ignore_changes = [security_rule]
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-snet-test-poc-01" {
  subnet_id                 = azurerm_subnet.snet-test-poc-01.id
  network_security_group_id = azurerm_network_security_group.nsg-snet-test-poc-01.id
}
##################################




############## NSG snet-test-poc-02 ##############
resource "azurerm_network_security_group" "nsg-snet-test-poc-02" {
  name                = "nsg-snet-test-poc-02"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location

  security_rule {
    name                       = "AllowSubnetInBound"
    priority                   = 4094
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["192.10.0.32/27"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyOtherSubnetsInBound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  lifecycle {
    ignore_changes = [security_rule]
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-snet-test-poc-02" {
  subnet_id                 = azurerm_subnet.snet-test-poc-02.id
  network_security_group_id = azurerm_network_security_group.nsg-snet-test-poc-02.id
}
##################################




############## NSG snet-test-poc-03 ##############
resource "azurerm_network_security_group" "nsg-snet-test-poc-03" {
  name                = "nsg-snet-test-poc-03"
  resource_group_name = azurerm_resource_group.Resource_Group.name
  location            = azurerm_resource_group.Resource_Group.location

  security_rule {
    name                       = "AllowSubnetInBound"
    priority                   = 4094
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["192.10.0.64/27"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyOtherSubnetsInBound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  lifecycle {
    ignore_changes = [security_rule]
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-snet-test-poc-03" {
  subnet_id                 = azurerm_subnet.snet-test-poc-03.id
  network_security_group_id = azurerm_network_security_group.nsg-snet-test-poc-03.id
}
##################################