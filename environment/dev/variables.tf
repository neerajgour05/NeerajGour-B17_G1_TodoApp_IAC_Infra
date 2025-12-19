variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))
}

variable "storage_accounts" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    tags                     = map(string)
  }))
}


variable "networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string))
    subnets = optional(list(object({
      name             = string
      address_prefixes = list(string)
    })), [], )
  }))
}


variable "public_ips" {
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string # Static / Dynamic
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    zones                   = optional(list(string), [])
    ip_version              = optional(string, "IPv4")
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number, 4)
    ip_tags                 = optional(map(string), {})
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    tags                    = optional(map(string), )
  }))
}

variable "vms" {
  type = map(object({
    nic_name               = string
    vm_name                = string
    location               = string
    resource_group_name    = string
    vnet_name              = string
    subnet_name            = string
    pip_name               = string
    size                   = string
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    admin_username = string
    admin_password = string
    tags           = optional(map(string))
  }))
}

variable "bastions" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    vnet_name           = string
    public_ip_name      = string
    sku                 = optional(string, "Standard")
    scale_units         = optional(number, 2)
    tags                = optional(map(string))
  }))
}

variable "key_vault" {

  type = map(object({
    name                        = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    tenant_id                   = string
    location                    = string
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool

    sku_name = string
   
  }))
}

variable "key_vault_secret" {
  type = map(object({
    secret_name         = string
    secret_value        = string
    resource_group_name = string
    key_name            = string
  }))
}

variable "sql_server" {
  type = map(object({
    name = string
    resource_group_name = string
    location = string
    version = string
    public_network_access_enabled = bool
    administrator_login = optional(string)
    administrator_login_password = optional(string)
    minimum_tls_version = optional(string)
    azuread_administrators = optional(list(object({
      login_username = string
      object_id      = string
 })))
  }))
}

variable "sql_database" {
 type = map(object({
  name = string
  # server_id    = string
  server_name    = string
  collation    = string
  license_type = string
  max_size_gb  = number
  sku_name     = string
  enclave_type = string
  resource_group_name = string

    }))
  
}