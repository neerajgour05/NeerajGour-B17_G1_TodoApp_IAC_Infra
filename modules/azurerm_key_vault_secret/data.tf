data "azurerm_key_vault" "keyid" {
  for_each            = var.key_vault_secret
  name                = each.value.key_name
  resource_group_name = each.value.resource_group_name
}