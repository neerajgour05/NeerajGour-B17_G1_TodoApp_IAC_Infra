rgs = {
 rg1 = {
   name       = "todoapp-rg"
   location   = "centralindia"
   managed_by = "Terraform"
   tags = {
     environment = "dev"
        }
 }
 rg2 = {
   name       = "todoapp-rg2"
   location   = "centralindia"
   managed_by = "Terraform"
   tags = {
     environment = "dev"
        }
 }
}

storage_accounts = {
  sa1 = {
  name                     = "devstgtodoappac"
  resource_group_name      = "todoapp-rg"
  location                 = "centralindia"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}
}

networks = {
  vnet1 = {
    name                = "devtodoapp-vnet"
    location            = "centralindia"
    resource_group_name = "todoapp-rg"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment = "dev"
    }
    subnets = [
      {
        name             = "frontend-dev-subnet"
        address_prefixes = ["10.0.1.0/24"]
      },

      {
        name             = "backend-dev-subnet"
        address_prefixes = ["10.0.2.0/24"]
      },

      {
        name             = "azurebastionsubnet"
        address_prefixes = ["10.0.3.0/27"]
      },
    ]
  }
 }

 public_ips = {
  app1 = {
    name                = "pip-frontend-todoapp"
    resource_group_name = "todoapp-rg"
    location            = "centralindia"
    allocation_method   = "Static"

    tags = {
      app = "frontend"
      env = "dev"
    }
  }
  app2 = {
    name                = "pip-backend-todoapp"
    resource_group_name = "todoapp-rg"
    location            = "centralindia"
    allocation_method   = "Static"

    tags = {
      app = "backend"
      env = "dev"
    }
  }
 }

vms = {
  vm1 = {
    nic_name    = "nic-frontend-vm-01"
    location    = "centralindia"
    resource_group_name     = "todoapp-rg"
    vnet_name   = "devtodoapp-vnet"
    subnet_name = "frontend-dev-subnet"
    pip_name    = "pip-frontend-todoapp"
    vm_name     = "frontend-vm"
    size        = "Standard_F2"
    admin_username = "devfrontendadmin"
    admin_password = "Frontend@12345"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  vm2 = {
    nic_name    = "nic-backend-vm-01"
    location    = "centralindia"
    resource_group_name     = "todoapp-rg"
    vnet_name   = "devtodoapp-vnet"
    subnet_name = "backend-dev-subnet"
    pip_name    = "pip-backend-todoapp"
    vm_name     = "backend-vm"
    size        = "Standard_F2"
    admin_username = "devbackendadmin"
    admin_password = "Backend@12345"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  
}

bastions = {
  bastion1 = {
    name                = "dev-bastion"
    location            = "centralindia"
    resource_group_name = "todoapp-rg"
    vnet_name           = "devtodoapp-vnet"
    public_ip_name      = "pip-frontend-todoapp"
    scale_units         = 2

    tags = {
      environment = "dev"
    }
  }
}

key_vault = {
  kv1 = {
    name                        = "kv-tododev"
    resource_group_name         = "todoapp-rg"
    location                    = "centralindia"
    enabled_for_disk_encryption = true
    tenant_id                   = "34969ee9-a0d2-43d0-bf8a-b3bd43c55eea"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    tags = {
      env = "dev"
    }
  }
}

key_vault_secret = {
  secret1 = {
    key_name            = "kv-dev"
    resource_group_name = "todoapp-rg"
    secret_name         = "admin"
    secret_value        = "admin"
  }
}

sql_server = {
  sql1 = {
    name = "sqlserver-tododev" 
    location = "centralindia"
    resource_group_name = "todoapp-rg"
    version = "12.0"
    administrator_login = "adminuser"
    administrator_login_password = "admin123"
    minimum_tls_version = "1.2"
    public_network_access_enabled = true
     
  }
}

sql_database = {
  db1 = {
    name         = "sqldatabse-tododev"
    # server_id   = "/subscriptions/2a6429ab-34bc-4c09-812c-9e5d8ceee0d7/resourceGroups/rg_dev/providers/Microsoft.Sql/servers/sqlserver-dev-uday01"
    server_name  = "sqlserver-tododev"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    resource_group_name = "todoapp-rg"
  }
}

