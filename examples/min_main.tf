resource "random_password" "password" {
  for_each = toset(["mysql_root", "postgresql_root", "mssql_admin"])

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
  mssql_server = {
    sql-mms = {
      resource_group_name          = "rg-mms-github"
      location                     = "westeurope"
      administrator_login          = "mssql_admin"
      administrator_login_password = random_password.password["mssql_admin"].result
      version                      = "12.0"
    }
  }
  mssql_database = {
    sqldb-mms = {
      server_id = module.database.mssql_server["sql-mms"].id
    }
  }
  mssql_firewall_rule = {
    AzureServices = {
      server_id        = module.database.mssql_server["sql-mms"].id
      start_ip_address = cidrhost("0.0.0.0/32", 0)
      end_ip_address   = cidrhost("0.0.0.0/32", -1)
    }
  }
}

