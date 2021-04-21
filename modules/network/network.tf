#https://github.com/Azure/terraform-azurerm-network/blob/master/main.tf
data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name #"${var.prefix}-vnet"
  location            = data.azurerm_resource_group.network.location
  address_space       = [var.address_space]
  resource_group_name = data.azurerm_resource_group.network.name #azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet_names
  name                 = each.key #"${var.prefix}-subnet"
  address_prefixes       = [each.value] #var.subnet_prefix
  resource_group_name  = data.azurerm_resource_group.network.name #azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "catapp-sg" {
  name                = "${var.prefix}-sg"
  location            = var.region
  resource_group_name = data.azurerm_resource_group.network.name #azurerm_resource_group.this.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "NOMAD"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4646"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}