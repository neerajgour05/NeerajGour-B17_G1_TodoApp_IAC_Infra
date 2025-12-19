module "resource_groups" {
  source = "../../modules/azurerm_resource_gorup"

  rgs = var.rgs
}

module "storage_accounts" {
  source     = "../../modules/azurerm_storage_account"
  depends_on = [module.resource_groups]

  storage_accounts = var.storage_accounts
}

module "network" {
  source = "../../modules/azurerm_networking"

  depends_on = [
    module.resource_groups
  ]

  networks = var.networks
}

module "public_ip" {
  source = "../../modules/azurerm_public_ip"
  depends_on = [module.resource_groups]

  public_ips = var.public_ips

}

module "compute" {
  source     = "../../modules/azurerm_compute"
  depends_on = [module.network, module.public_ip, module.storage_accounts]
  vms        = var.vms
}

module "bastion" {
  
  source     = "../../modules/azurerm_bastion"
  depends_on = [module.network, module.public_ip]

  bastions = var.bastions
}

module "key_vault" {
  depends_on = [module.resource_groups]
  source = "../../modules/azurerm_key_vault"
  key_vault = var.key_vault
}

module "key_vault_secret" {
  depends_on = [module.key_vault ]
  source = "../../modules/azurerm_key_vault_secret"
  key_vault_secret = var.key_vault_secret
}

module "sql_server" {
  depends_on = [ module.resource_groups ]
  source = "../../modules/azurerm_sql_server"
  sql_server = var.sql_server
}

module "sql_database" {
  depends_on = [ module.sql_server, module.resource_groups ]
   source = "../../modules/azurerm_sql_database"
   sql_database = var.sql_database
}