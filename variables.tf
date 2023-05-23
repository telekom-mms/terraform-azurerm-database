variable "mysql_flexible_server" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}
variable "mysql_flexible_server_firewall_rule" {
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
        auto_grow_enabled = null
        iops              = null
        size_gb           = null
      }
      tags = {}
    }
    mysql_flexible_server_firewall_rule = {
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
  mysql_flexible_server_firewall_rule = {
    for mysql_flexible_server_firewall_rule in keys(var.mysql_flexible_server_firewall_rule) :
    mysql_flexible_server_firewall_rule => merge(local.default.mysql_flexible_server_firewall_rule, var.mysql_flexible_server_firewall_rule[mysql_flexible_server_firewall_rule])
  }
}
