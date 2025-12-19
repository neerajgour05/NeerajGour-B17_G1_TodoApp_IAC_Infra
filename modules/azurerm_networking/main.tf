resource "azurerm_virtual_network" "Vnet" {
  for_each            = var.networks
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  tags                = each.value.tags

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }

  }

  subnet {
    name = "azurebastionsubnet"
    address_prefixes = ["10.0.3.0/27"]
  }

}

