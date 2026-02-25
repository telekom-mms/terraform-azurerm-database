variable "mssql_server" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "mssql_database" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "mssql_virtual_network_rule" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "mssql_firewall_rule" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "mysql_flexible_server" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "mysql_flexible_server_configuration" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "mysql_flexible_database" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "mysql_flexible_server_firewall_rule" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "postgresql_flexible_server" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "postgresql_flexible_server_configuration" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "postgresql_flexible_server_database" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

variable "postgresql_flexible_server_firewall_rule" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}


locals {
  default = {
    // MSSQL resources
    mssql_server = {
      name                                 = ""
      version                              = "12.0"
      administrator_login                  = null
      administrator_login_password         = null
      connection_policy                    = null
      minimum_tls_version                  = null
      public_network_access_enabled        = null
      outbound_network_restriction_enabled = null
      primary_user_assigned_identity_id    = null
      azuread_administrator                = {}
      identity = {
        type         = ""
        identity_ids = null
      }
      azuread_administrator = {
        login_username              = ""
        object_id                   = ""
        tenant_id                   = null
        azuread_authentication_only = null
      }
      tags                        = {}
      sql_authentication_disabled = false
    }
    mssql_database = {
      name                                = ""
      auto_pause_delay_in_minutes         = null
      create_mode                         = null
      creation_source_database_id         = null
      collation                           = null
      elastic_pool_id                     = null
      geo_backup_enabled                  = null
      ledger_enabled                      = null
      license_type                        = null
      max_size_gb                         = null
      min_capacity                        = null
      restore_point_in_time               = null
      recover_database_id                 = null
      restore_dropped_database_id         = null
      read_replica_count                  = null
      read_scale                          = null
      sample_name                         = null
      sku_name                            = null
      storage_account_type                = null
      transparent_data_encryption_enabled = null
      zone_redundant                      = null
      long_term_retention_policy = {
        weekly_retention  = null
        monthly_retention = null
        yearly_retention  = null
        week_of_year      = null
      }
      short_term_retention_policy = {
        retention_days           = null
        backup_interval_in_hours = null
      }
      threat_detection_policy = {
        state                      = ""
        disabled_alerts            = null
        email_account_admins       = null
        email_addresses            = null
        retention_days             = null
        storage_account_access_key = null
        storage_endpoint           = null
      }
      tags = {}
    }
    mssql_virtual_network_rule = {
      name                                 = ""
      server_id                            = ""
      subnet_id                            = ""
      ignore_missing_vnet_service_endpoint = false
    }
    mssql_firewall_rule = {
      name             = ""
      server_id        = ""
      start_ip_address = ""
      end_ip_address   = ""
    }

    // MySQL resources
    mysql_flexible_server = {
      name                              = ""
      administrator_login               = null
      administrator_password            = null
      backup_retention_days             = null
      create_mode                       = "Default"
      delegated_subnet_id               = null
      geo_redundant_backup_enabled      = null
      point_in_time_restore_time_in_utc = null
      private_dns_zone_id               = null
      replication_role                  = null
      sku_name                          = null
      source_server_id                  = null
      version                           = null
      zone                              = null
      customer_managed_key = {
        key_vault_key_id                     = null
        primary_user_assigned_identity_id    = null
        geo_backup_key_vault_key_id          = null
        geo_backup_user_assigned_identity_id = null
      }
      high_availability = {
        standby_availability_zone = null
      }
      identity = {}
      maintenance_window = {
        day_of_week  = null
        start_hour   = null
        start_minute = null
      }
      storage = {
        auto_grow_enabled  = null
        io_scaling_enabled = null
        iops               = null
        size_gb            = null
      }
      tags = {}
    }
    mysql_flexible_server_configuration = {
      name = ""
    }
    mysql_flexible_database = {
      name      = ""
      charset   = "utf8mb4"
      collation = "utf8mb4_unicode_ci"
    }
    mysql_flexible_server_firewall_rule = {
      name = ""
    }

    // PostgreSQL resources
    postgresql_flexible_server = {
      name                              = ""
      administrator_login               = null
      administrator_password            = null
      backup_retention_days             = null
      create_mode                       = "Default"
      delegated_subnet_id               = null
      geo_redundant_backup_enabled      = null
      point_in_time_restore_time_in_utc = null
      private_dns_zone_id               = null
      replication_role                  = null
      sku_name                          = null
      source_server_id                  = null
      auto_grow_enabled                 = true
      storage_mb                        = null
      version                           = null
      zone                              = null
      authentication                    = {}
      customer_managed_key              = {}
      high_availability = {
        standby_availability_zone = null
      }
      identity           = {}
      maintenance_window = {}
      tags               = {}
    }
    postgresql_flexible_server_configuration = {
      name = ""
    }
    postgresql_flexible_server_database = {
      name      = ""
      charset   = "UTF8"
      collation = "de-DE"
    }
    postgresql_flexible_server_firewall_rule = {
      name = ""
    }
  }

  // compare and merge custom and default values
  mssql_server_values = {
    for mssql_server in keys(var.mssql_server) :
    mssql_server => merge(local.default.mssql_server, var.mssql_server[mssql_server])
  }
  mssql_database_values = {
    for mssql_database in keys(var.mssql_database) :
    mssql_database => merge(local.default.mssql_database, var.mssql_database[mssql_database])
  }
  mssql_virtual_network_rule_values = {
    for rule in keys(var.mssql_virtual_network_rule) :
    rule => merge(local.default.mssql_virtual_network_rule, var.mssql_virtual_network_rule[rule])
  }
  mssql_firewall_rule_values = {
    for rule in keys(var.mssql_firewall_rule) :
    rule => merge(local.default.mssql_firewall_rule, var.mssql_firewall_rule[rule])
  }

  mysql_flexible_server_values = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(local.default.mysql_flexible_server, var.mysql_flexible_server[mysql_flexible_server])
  }

  postgresql_flexible_server_values = {
    for postgresql_flexible_server in keys(var.postgresql_flexible_server) :
    postgresql_flexible_server => merge(local.default.postgresql_flexible_server, var.postgresql_flexible_server[postgresql_flexible_server])
  }

  // deep merge of all custom and default values
  mssql_server = {
    for mssql_server in keys(var.mssql_server) :
    mssql_server => merge(
      local.mssql_server_values[mssql_server],
      {
        for config in ["identity", "azuread_administrator"] :
        config => merge(local.default.mssql_server[config], local.mssql_server_values[mssql_server][config])
      }
    )
  }
  mssql_database = {
    for mssql_database in keys(var.mssql_database) :
    mssql_database => merge(
      local.mssql_database_values[mssql_database],
      {
        for config in ["threat_detection_policy", "long_term_retention_policy", "short_term_retention_policy"] :
        config => merge(local.default.mssql_database[config], local.mssql_database_values[mssql_database][config])
      }
    )
  }
  mssql_virtual_network_rule = {
    for rule in keys(var.mssql_virtual_network_rule) :
    rule => local.mssql_virtual_network_rule_values[rule]
  }
  mssql_firewall_rule = {
    for rule in keys(var.mssql_firewall_rule) :
    rule => local.mssql_firewall_rule_values[rule]
  }

  mysql_flexible_server = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(
      local.mysql_flexible_server_values[mysql_flexible_server],
      {
        for config in [
          "customer_managed_key",
          "high_availability",
          "identity",
          "maintenance_window",
          "storage"
        ] :
        config => merge(local.default.mysql_flexible_server[config], local.mysql_flexible_server_values[mysql_flexible_server][config])
      }
    )
  }

  mysql_flexible_server_configuration = {
    for mysql_flexible_server_configuration in keys(var.mysql_flexible_server_configuration) :
    mysql_flexible_server_configuration => merge(local.default.mysql_flexible_server_configuration, var.mysql_flexible_server_configuration[mysql_flexible_server_configuration])
  }
  mysql_flexible_database = {
    for mysql_flexible_database in keys(var.mysql_flexible_database) :
    mysql_flexible_database => merge(local.default.mysql_flexible_database, var.mysql_flexible_database[mysql_flexible_database])
  }
  mysql_flexible_server_firewall_rule = {
    for mysql_flexible_server_firewall_rule in keys(var.mysql_flexible_server_firewall_rule) :
    mysql_flexible_server_firewall_rule => merge(local.default.mysql_flexible_server_firewall_rule, var.mysql_flexible_server_firewall_rule[mysql_flexible_server_firewall_rule])
  }

  postgresql_flexible_server = {
    for postgresql_flexible_server in keys(var.postgresql_flexible_server) :
    postgresql_flexible_server => merge(
      local.postgresql_flexible_server_values[postgresql_flexible_server],
      {
        for config in [
          "authentication",
          "customer_managed_key",
          "high_availability",
          "identity",
          "maintenance_window",
        ] :
        config => merge(local.default.postgresql_flexible_server[config], local.postgresql_flexible_server_values[postgresql_flexible_server][config])
      }
    )
  }

  postgresql_flexible_server_configuration = {
    for postgresql_flexible_server_configuration in keys(var.postgresql_flexible_server_configuration) :
    postgresql_flexible_server_configuration => merge(local.default.postgresql_flexible_server_configuration, var.postgresql_flexible_server_configuration[postgresql_flexible_server_configuration])
  }
  postgresql_flexible_server_database = {
    for postgresql_flexible_server_database in keys(var.postgresql_flexible_server_database) :
    postgresql_flexible_server_database => merge(local.default.postgresql_flexible_server_database, var.postgresql_flexible_server_database[postgresql_flexible_server_database])
  }
  postgresql_flexible_server_firewall_rule = {
    for postgresql_flexible_server_firewall_rule in keys(var.postgresql_flexible_server_firewall_rule) :
    postgresql_flexible_server_firewall_rule => merge(local.default.postgresql_flexible_server_firewall_rule, var.postgresql_flexible_server_firewall_rule[postgresql_flexible_server_firewall_rule])
  }
}
