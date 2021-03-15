//--------------------------------------------------------------------
// Workspace Data
data "terraform_remote_state" "pphan_servicenow_hashicat_azure_network" {
  backend = "remote"
  config = {
    organization = "pphan-servicenow"
    workspaces   = { name = "hashicat-azure-network" }
  }
}

# data "azurerm_resource_group" "network" {
#   name = azurerm_resource_group.myresourcegroup.name
# }
