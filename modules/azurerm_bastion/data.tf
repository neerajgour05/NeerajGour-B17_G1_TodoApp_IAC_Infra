data "azurerm_virtual_network" "vnet" {
  for_each            = var.bastions
  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "bastion" {
  

  name                 = "AzureBastionSubnet"
  virtual_network_name = "devtodoapp-vnet"
  resource_group_name  = "todoapp-rg"
}
data "azurerm_public_ip" "pip" {
  
  name                = "pip-bastion-todoapp"
  resource_group_name = "todoapp-rg"
}
