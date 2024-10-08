<!-- BEGIN_TF_DOCS -->
# database

This module manages the azurerm database resources.
For more information see https://registry.terraform.io/providers/azurerm/latest/docs > database

_<-- This file is autogenerated, please do not change. -->_

## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.3 |
| azurerm | >=3.75.0, <4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=3.75.0, <4.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_mysql_flexible_database.mysql_flexible_database | resource |
| azurerm_mysql_flexible_server.mysql_flexible_server | resource |
| azurerm_mysql_flexible_server_configuration.mysql_flexible_server_configuration | resource |
| azurerm_mysql_flexible_server_firewall_rule.mysql_flexible_server_firewall_rule | resource |
| azurerm_postgresql_flexible_server.postgresql_flexible_server | resource |
| azurerm_postgresql_flexible_server_configuration.postgresql_flexible_server_configuration | resource |
| azurerm_postgresql_flexible_server_database.postgresql_flexible_server_database | resource |
| azurerm_postgresql_flexible_server_firewall_rule.postgresql_flexible_server_firewall_rule | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| mysql_flexible_database | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| mysql_flexible_server | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| mysql_flexible_server_configuration | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| mysql_flexible_server_firewall_rule | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| postgresql_flexible_server | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| postgresql_flexible_server_configuration | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| postgresql_flexible_server_database | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |
| postgresql_flexible_server_firewall_rule | Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs). | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| mysql_flexible_database | Outputs all attributes of resource_type. |
| mysql_flexible_server | Outputs all attributes of resource_type. |
| mysql_flexible_server_configuration | Outputs all attributes of resource_type. |
| mysql_flexible_server_firewall_rule | Outputs all attributes of resource_type. |
| postgresql_flexible_server | Outputs all attributes of resource_type. |
| postgresql_flexible_server_configuration | Outputs all attributes of resource_type. |
| postgresql_flexible_server_database | Outputs all attributes of resource_type. |
| postgresql_flexible_server_firewall_rule | Outputs all attributes of resource_type. |
| variables | Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module |

## Examples

Minimal configuration to install the desired resources with the module

```hcl
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
}
```

Advanced configuration to install the desired resources with the module

```hcl
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
        io_scaling_enabled = true
        size_gb            = 20
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
```
<!-- END_TF_DOCS -->