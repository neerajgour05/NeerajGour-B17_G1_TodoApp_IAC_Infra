data "azurerm_virtual_network" "vnet" {
  for_each            = var.bastions
  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "bastion" {
  for_each = var.bastions

  name                 = "azurebastionsubnet"
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_public_ip" "pip" {
  for_each            = var.bastions
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
