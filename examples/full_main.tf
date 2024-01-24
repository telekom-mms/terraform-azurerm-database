resource "random_password" "password" {
  for_each = toset(["mysql_root", "postgresql_root"])

  length  = 16
  special = false
}

module "database" {
  source = "registry.terraform.io/telekom-mms/database/azurerm"
  mysql_flexible_server = {
    mysql-mms = {
      location               = "westeurope"
      resource_group_name    = "rg-mms-github"
      administrator_login    = "mysql_root"
      administrator_password = random_password.password["mysql_root"].result
      sku_name               = "GP_Standard_D2ds_v4"
      version                = "8.0.21"
      zone                   = "1"
      storage = {
        size_gb = 20
      }
      high_availability = {
        mode                      = "ZoneRedundant"
        standby_availability_zone = 2
      }
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  mysql_flexible_server_configuration = {
    interactive_timeout = {
      resource_group_name = module.database.mysql_flexible_server["mysql-mms"].resource_group_name
      server_name         = module.database.mysql_flexible_server["mysql-mms"].name
      value               = "600"
    }
  }
  mysql_flexible_database = {
    application = {
      resource_group_name = module.database.mysql_flexible_server["mysql-mms"].resource_group_name
      server_name         = module.database.mysql_flexible_server["mysql-mms"].name
    }
  }
  mysql_flexible_server_firewall_rule = {
    AzureServices = {
      server_name         = module.database.mysql_flexible_server["mysql-mms"].name
      resource_group_name = module.database.mysql_flexible_server["mysql-mms"].resource_group_name
      start_ip_address    = cidrhost("0.0.0.0/32", 0)
      end_ip_address      = cidrhost("0.0.0.0/32", -1)
    }
  }

  postgresql_flexible_server = {
    postgresql-mms = {
      location               = "westeurope"
      resource_group_name    = "rg-mms-github"
      administrator_login    = "postgresql_root"
      administrator_password = random_password.password["postgresql_root"].result
      sku_name               = "GP_Standard_D2ds_v5"
      storage_mb             = 32768
      version                = "16"
      zone                   = "1"
      high_availability = {
        mode                      = "ZoneRedundant"
        standby_availability_zone = 2
      }
      tags = {
        project     = "mms-github"
        environment = terraform.workspace
        managed-by  = "terraform"
      }
    }
  }
  postgresql_flexible_server_configuration = {
    backslash_quote = {
      server_id = module.database.postgresql_flexible_server["postgresql-mms"].id
      value     = "on"
    }
  }
  postgresql_flexible_server_database = {
    application = {
      server_id = module.database.postgresql_flexible_server["postgresql-mms"].id
    }
  }
  postgresql_flexible_server_firewall_rule = {
    AzureServices = {
      server_id        = module.database.postgresql_flexible_server["postgresql-mms"].id
      start_ip_address = cidrhost("0.0.0.0/32", 0)
      end_ip_address   = cidrhost("0.0.0.0/32", -1)
    }
  }
}
