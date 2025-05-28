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
variable "mysql_flexible_server_active_directory_administrator" {
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
    mysql_flexible_server_active_directory_administrator = {}

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

  /**
    compare and merge custom and default values
  */
  mysql_flexible_server_values = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(local.default.mysql_flexible_server, var.mysql_flexible_server[mysql_flexible_server])
  }

  /**
    compare and merge custom and default values
  */
  postgresql_flexible_server_values = {
    for postgresql_flexible_server in keys(var.postgresql_flexible_server) :
    postgresql_flexible_server => merge(local.default.postgresql_flexible_server, var.postgresql_flexible_server[postgresql_flexible_server])
  }

  /**
    deep merge of all custom and default values
  */
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
  mysql_flexible_server_active_directory_administrator = {
    for mysql_flexible_server_active_directory_administrator in keys(var.mysql_flexible_server_active_directory_administrator) :
    mysql_flexible_server_active_directory_administrator => merge(local.default.mysql_flexible_server_active_directory_administrator, var.mysql_flexible_server_active_directory_administrator[mysql_flexible_server_active_directory_administrator])
  }

  /**
    deep merge of all custom and default values
  */
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
