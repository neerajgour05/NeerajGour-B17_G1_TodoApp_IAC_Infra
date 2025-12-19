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
