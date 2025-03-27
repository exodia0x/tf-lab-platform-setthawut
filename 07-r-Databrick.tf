############## DataBrick Workspace ##############
// adbtestprovision
resource "azurerm_databricks_workspace" "databricks-adbtestprovision" {
  name                          = "adbtestprovision"
  resource_group_name           = azurerm_resource_group.Resource_Group.name
  location                      = azurerm_resource_group.Resource_Group.location
  sku                           = "premium"
  public_network_access_enabled = true

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = azurerm_subnet.snet-test-poc-01.name
    private_subnet_name = azurerm_subnet.snet-test-poc-02.name
    virtual_network_id  = azurerm_virtual_network.vnet.id

    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.nsg-snet-test-poc-01.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.nsg-snet-test-poc-02.id
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.nsg-snet-test-poc-01,
    azurerm_subnet_network_security_group_association.nsg-snet-test-poc-02,
    azurerm_subnet.snet-test-poc-01,
    azurerm_subnet.snet-test-poc-02,
  ]
}

// testprocessing Cluster
resource "databricks_cluster" "testprocessing" {
  cluster_name        = "testprocessing"
  spark_version       = "13.3.x-scala2.12"
  node_type_id        = "Standard_E4ds_v4"
  driver_node_type_id = "Standard_E4ds_v4"
  data_security_mode  = "USER_ISOLATION"
  # data_security_mode = "DATA_SECURITY_MODE_STANDARD"

  autoscale {
    min_workers = 1
    max_workers = 2
  }

  depends_on = [azurerm_databricks_workspace.databricks-adbtestprovision]
}
##################################



# data "databricks_spark_version" "latest_lts" {
#   long_term_support = true
# }

# output "databricks_version" {
#   value = data.databricks_spark_version.latest_lts
# }

# data "databricks_node_type" "smallest" {
#   local_disk = true
# }

# output "databricks_nodetype" {
#   value = data.databricks_node_type.smallest
# }