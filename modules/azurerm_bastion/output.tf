output "bastion_ids" {
  value = {
    for k, b in azurerm_bastion_host.bastion : k => b.id
  }
}

output "bastion_names" {
  value = {
    for k, b in azurerm_bastion_host.bastion : k => b.name
  }
}
