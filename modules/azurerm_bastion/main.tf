resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  scale_units         = each.value.scale_units

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = data.azurerm_subnet.bastion.id
    public_ip_address_id = data.azurerm_public_ip.pip.id
  }

  tags = each.value.tags
}
