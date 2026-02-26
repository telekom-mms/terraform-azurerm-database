/**
* # database
*
* This module manages the azurerm database resources.
* For more information see https://registry.terraform.io/providers/azurerm/latest/docs > database
*
*/

resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  for_each = var.mysql_flexible_server

  name                              = local.mysql_flexible_server[each.key].name == "" ? each.key : local.mysql_flexible_server[each.key].name
  resource_group_name               = local.mysql_flexible_server[each.key].resource_group_name
  location                          = local.mysql_flexible_server[each.key].location
  administrator_login               = local.mysql_flexible_server[each.key].administrator_login
  administrator_password            = local.mysql_flexible_server[each.key].administrator_password
  backup_retention_days             = local.mysql_flexible_server[each.key].backup_retention_days
  create_mode                       = local.mysql_flexible_server[each.key].create_mode
  delegated_subnet_id               = local.mysql_flexible_server[each.key].delegated_subnet_id
  geo_redundant_backup_enabled      = local.mysql_flexible_server[each.key].geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = local.mysql_flexible_server[each.key].point_in_time_restore_time_in_utc
  private_dns_zone_id               = local.mysql_flexible_server[each.key].private_dns_zone_id
  replication_role                  = local.mysql_flexible_server[each.key].replication_role
  sku_name                          = local.mysql_flexible_server[each.key].sku_name
  source_server_id                  = local.mysql_flexible_server[each.key].source_server_id
  version                           = local.mysql_flexible_server[each.key].version
  zone                              = local.mysql_flexible_server[each.key].zone

  dynamic "customer_managed_key" {
    for_each = length(compact(values(local.mysql_flexible_server[each.key].customer_managed_key))) > 0 ? [0] : []

    content {
      key_vault_key_id                     = local.mysql_flexible_server[each.key].customer_managed_key.key_vault_key_id
      primary_user_assigned_identity_id    = local.mysql_flexible_server[each.key].customer_managed_key.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = local.mysql_flexible_server[each.key].customer_managed_key.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = local.mysql_flexible_server[each.key].customer_managed_key.geo_backup_user_assigned_identity_id
    }
  }

  dynamic "high_availability" {
    for_each = length(compact(values(local.mysql_flexible_server[each.key].high_availability))) > 0 ? [0] : []

    content {
      mode                      = local.mysql_flexible_server[each.key].high_availability.mode
      standby_availability_zone = local.mysql_flexible_server[each.key].high_availability.standby_availability_zone
    }
  }

  dynamic "identity" {
    for_each = local.mysql_flexible_server[each.key].identity == {} ? [] : [0]

    content {
      type         = local.mysql_flexible_server[each.key].identity.type
      identity_ids = local.mysql_flexible_server[each.key].identity.identity_ids
    }
  }

  dynamic "maintenance_window" {
    for_each = length(compact(values(local.mysql_flexible_server[each.key].maintenance_window))) > 0 ? [0] : []

    content {
      day_of_week  = local.mysql_flexible_server[each.key].maintenance_window.day_of_week
      start_hour   = local.mysql_flexible_server[each.key].maintenance_window.start_hour
      start_minute = local.mysql_flexible_server[each.key].maintenance_window.start_minute
    }
  }

  dynamic "storage" {
    for_each = length(compact(values(local.mysql_flexible_server[each.key].storage))) > 0 ? [0] : []

    content {
      auto_grow_enabled  = local.mysql_flexible_server[each.key].storage.auto_grow_enabled
      io_scaling_enabled = local.mysql_flexible_server[each.key].storage.io_scaling_enabled
      iops               = local.mysql_flexible_server[each.key].storage.iops
      size_gb            = local.mysql_flexible_server[each.key].storage.size_gb
    }
  }

  tags = local.mysql_flexible_server[each.key].tags
}

resource "azurerm_mysql_flexible_server_configuration" "mysql_flexible_server_configuration" {
  for_each = var.mysql_flexible_server_configuration

  name                = local.mysql_flexible_server_configuration[each.key].name == "" ? each.key : local.mysql_flexible_server_configuration[each.key].name
  resource_group_name = local.mysql_flexible_server_configuration[each.key].resource_group_name
  server_name         = local.mysql_flexible_server_configuration[each.key].server_name
  value               = local.mysql_flexible_server_configuration[each.key].value
}

resource "azurerm_mysql_flexible_database" "mysql_flexible_database" {
  for_each = var.mysql_flexible_database

  name                = local.mysql_flexible_database[each.key].name == "" ? each.key : local.mysql_flexible_database[each.key].name
  resource_group_name = local.mysql_flexible_database[each.key].resource_group_name
  server_name         = local.mysql_flexible_database[each.key].server_name
  charset             = local.mysql_flexible_database[each.key].charset
  collation           = local.mysql_flexible_database[each.key].collation
}

resource "azurerm_mysql_flexible_server_firewall_rule" "mysql_flexible_server_firewall_rule" {
  for_each = var.mysql_flexible_server_firewall_rule

  name                = local.mysql_flexible_server_firewall_rule[each.key].name == "" ? each.key : local.mysql_flexible_server_firewall_rule[each.key].name
  server_name         = local.mysql_flexible_server_firewall_rule[each.key].server_name
  resource_group_name = local.mysql_flexible_server_firewall_rule[each.key].resource_group_name
  start_ip_address    = local.mysql_flexible_server_firewall_rule[each.key].start_ip_address
  end_ip_address      = local.mysql_flexible_server_firewall_rule[each.key].end_ip_address
}

resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  for_each = var.postgresql_flexible_server

  name                              = local.postgresql_flexible_server[each.key].name == "" ? each.key : local.postgresql_flexible_server[each.key].name
  resource_group_name               = local.postgresql_flexible_server[each.key].resource_group_name
  location                          = local.postgresql_flexible_server[each.key].location
  administrator_login               = local.postgresql_flexible_server[each.key].administrator_login
  administrator_password            = local.postgresql_flexible_server[each.key].administrator_password
  backup_retention_days             = local.postgresql_flexible_server[each.key].backup_retention_days
  create_mode                       = local.postgresql_flexible_server[each.key].create_mode
  delegated_subnet_id               = local.postgresql_flexible_server[each.key].delegated_subnet_id
  geo_redundant_backup_enabled      = local.postgresql_flexible_server[each.key].geo_redundant_backup_enabled
  point_in_time_restore_time_in_utc = local.postgresql_flexible_server[each.key].point_in_time_restore_time_in_utc
  private_dns_zone_id               = local.postgresql_flexible_server[each.key].private_dns_zone_id
  replication_role                  = local.postgresql_flexible_server[each.key].replication_role
  sku_name                          = local.postgresql_flexible_server[each.key].sku_name
  source_server_id                  = local.postgresql_flexible_server[each.key].source_server_id
  auto_grow_enabled                 = local.postgresql_flexible_server[each.key].auto_grow_enabled
  storage_mb                        = local.postgresql_flexible_server[each.key].storage_mb
  version                           = local.postgresql_flexible_server[each.key].version
  zone                              = local.postgresql_flexible_server[each.key].zone


  dynamic "authentication" {
    for_each = length(compact(values(local.postgresql_flexible_server[each.key].authentication))) > 0 ? [0] : []

    content {
      active_directory_auth_enabled = local.postgresql_flexible_server[each.key].authentication_key.active_directory_auth_enabled
      password_auth_enabled         = local.postgresql_flexible_server[each.key].authentication_key.password_auth_enabled
      tenant_id                     = local.postgresql_flexible_server[each.key].authentication_key.tenant_id
    }
  }

  dynamic "customer_managed_key" {
    for_each = length(compact(values(local.postgresql_flexible_server[each.key].customer_managed_key))) > 0 ? [0] : []

    content {
      key_vault_key_id                     = local.postgresql_flexible_server[each.key].customer_managed_key.key_vault_key_id
      primary_user_assigned_identity_id    = local.postgresql_flexible_server[each.key].customer_managed_key.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = local.postgresql_flexible_server[each.key].customer_managed_key.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = local.postgresql_flexible_server[each.key].customer_managed_key.geo_backup_user_assigned_identity_id
    }
  }

  dynamic "high_availability" {
    for_each = length(compact(values(local.postgresql_flexible_server[each.key].high_availability))) > 0 ? [0] : []

    content {
      mode                      = local.postgresql_flexible_server[each.key].high_availability.mode
      standby_availability_zone = local.postgresql_flexible_server[each.key].high_availability.standby_availability_zone
    }
  }

  dynamic "identity" {
    for_each = local.postgresql_flexible_server[each.key].identity == {} ? [] : [0]

    content {
      type         = local.postgresql_flexible_server[each.key].identity.type
      identity_ids = local.postgresql_flexible_server[each.key].identity.identity_ids
    }
  }

  dynamic "maintenance_window" {
    for_each = length(compact(values(local.postgresql_flexible_server[each.key].maintenance_window))) > 0 ? [0] : []

    content {
      day_of_week  = local.postgresql_flexible_server[each.key].maintenance_window.day_of_week
      start_hour   = local.postgresql_flexible_server[each.key].maintenance_window.start_hour
      start_minute = local.postgresql_flexible_server[each.key].maintenance_window.start_minute
    }
  }
  tags = local.postgresql_flexible_server[each.key].tags
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_server_configuration" {
  for_each = var.postgresql_flexible_server_configuration

  name      = local.postgresql_flexible_server_configuration[each.key].name == "" ? each.key : local.postgresql_flexible_server_configuration[each.key].name
  server_id = local.postgresql_flexible_server_configuration[each.key].server_id
  value     = local.postgresql_flexible_server_configuration[each.key].value
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_server_database" {
  for_each = var.postgresql_flexible_server_database

  name      = local.postgresql_flexible_server_database[each.key].name == "" ? each.key : local.postgresql_flexible_server_database[each.key].name
  server_id = local.postgresql_flexible_server_database[each.key].server_id
  charset   = local.postgresql_flexible_server_database[each.key].charset
  collation = local.postgresql_flexible_server_database[each.key].collation
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "postgresql_flexible_server_firewall_rule" {
  for_each = var.postgresql_flexible_server_firewall_rule

  name             = local.postgresql_flexible_server_firewall_rule[each.key].name == "" ? each.key : local.postgresql_flexible_server_firewall_rule[each.key].name
  server_id        = local.postgresql_flexible_server_firewall_rule[each.key].server_id
  start_ip_address = local.postgresql_flexible_server_firewall_rule[each.key].start_ip_address
  end_ip_address   = local.postgresql_flexible_server_firewall_rule[each.key].end_ip_address
}

resource "azurerm_mssql_server" "mssql_server" {
  for_each = var.mssql_server

  name                                 = local.mssql_server[each.key].name == "" ? each.key : local.mssql_server[each.key].name
  resource_group_name                  = local.mssql_server[each.key].resource_group_name
  location                             = local.mssql_server[each.key].location
  version                              = local.mssql_server[each.key].version
  administrator_login                  = local.mssql_server[each.key].administrator_login
  administrator_login_password         = local.mssql_server[each.key].administrator_login_password
  connection_policy                    = local.mssql_server[each.key].connection_policy
  minimum_tls_version                  = local.mssql_server[each.key].minimum_tls_version
  public_network_access_enabled        = local.mssql_server[each.key].public_network_access_enabled
  outbound_network_restriction_enabled = local.mssql_server[each.key].outbound_network_restriction_enabled
  primary_user_assigned_identity_id    = local.mssql_server[each.key].primary_user_assigned_identity_id

  dynamic "identity" {
    for_each = local.mssql_server[each.key].identity.type != "" ? [1] : []

    content {
      type         = local.mssql_server[each.key].identity.type
      identity_ids = local.mssql_server[each.key].identity.identity_ids
    }
  }

  dynamic "azuread_administrator" {
    for_each = local.mssql_server[each.key].azuread_administrator.login_username != "" ? [1] : []

    content {
      login_username              = local.mssql_server[each.key].azuread_administrator.login_username
      object_id                   = local.mssql_server[each.key].azuread_administrator.object_id
      tenant_id                   = local.mssql_server[each.key].azuread_administrator.tenant_id
      azuread_authentication_only = local.mssql_server[each.key].azuread_administrator.azuread_authentication_only
    }
  }

  tags = local.mssql_server[each.key].tags
}

resource "azurerm_mssql_database" "mssql_database" {
  for_each = var.mssql_database

  name                                = local.mssql_database[each.key].name == "" ? each.key : local.mssql_database[each.key].name
  server_id                           = local.mssql_database[each.key].server_id
  auto_pause_delay_in_minutes         = local.mssql_database[each.key].auto_pause_delay_in_minutes
  create_mode                         = local.mssql_database[each.key].create_mode
  creation_source_database_id         = local.mssql_database[each.key].creation_source_database_id
  collation                           = local.mssql_database[each.key].collation
  elastic_pool_id                     = local.mssql_database[each.key].elastic_pool_id
  geo_backup_enabled                  = local.mssql_database[each.key].geo_backup_enabled
  ledger_enabled                      = local.mssql_database[each.key].ledger_enabled
  license_type                        = local.mssql_database[each.key].license_type
  max_size_gb                         = local.mssql_database[each.key].max_size_gb
  min_capacity                        = local.mssql_database[each.key].min_capacity
  restore_point_in_time               = local.mssql_database[each.key].restore_point_in_time
  recover_database_id                 = local.mssql_database[each.key].recover_database_id
  restore_dropped_database_id         = local.mssql_database[each.key].restore_dropped_database_id
  read_replica_count                  = local.mssql_database[each.key].read_replica_count
  read_scale                          = local.mssql_database[each.key].read_scale
  sample_name                         = local.mssql_database[each.key].sample_name
  sku_name                            = local.mssql_database[each.key].sku_name
  storage_account_type                = local.mssql_database[each.key].storage_account_type
  transparent_data_encryption_enabled = local.mssql_database[each.key].transparent_data_encryption_enabled
  zone_redundant                      = local.mssql_database[each.key].zone_redundant

  dynamic "threat_detection_policy" {
    for_each = local.mssql_database[each.key].threat_detection_policy.state != "" ? [1] : []

    content {
      state                      = local.mssql_database[each.key].threat_detection_policy.state
      disabled_alerts            = local.mssql_database[each.key].threat_detection_policy.disabled_alerts
      email_account_admins       = local.mssql_database[each.key].threat_detection_policy.email_account_admins
      email_addresses            = local.mssql_database[each.key].threat_detection_policy.email_addresses
      retention_days             = local.mssql_database[each.key].threat_detection_policy.retention_days
      storage_account_access_key = local.mssql_database[each.key].threat_detection_policy.storage_account_access_key
      storage_endpoint           = local.mssql_database[each.key].threat_detection_policy.storage_endpoint
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = length(compact([
      local.mssql_database[each.key].long_term_retention_policy.weekly_retention,
      local.mssql_database[each.key].long_term_retention_policy.monthly_retention,
      local.mssql_database[each.key].long_term_retention_policy.yearly_retention,
      local.mssql_database[each.key].long_term_retention_policy.week_of_year
    ])) > 0 ? [1] : []

    content {
      weekly_retention  = local.mssql_database[each.key].long_term_retention_policy.weekly_retention
      monthly_retention = local.mssql_database[each.key].long_term_retention_policy.monthly_retention
      yearly_retention  = local.mssql_database[each.key].long_term_retention_policy.yearly_retention
      week_of_year      = local.mssql_database[each.key].long_term_retention_policy.week_of_year
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = local.mssql_database[each.key].short_term_retention_policy.retention_days != null ? [1] : []

    content {
      retention_days           = local.mssql_database[each.key].short_term_retention_policy.retention_days
      backup_interval_in_hours = local.mssql_database[each.key].short_term_retention_policy.backup_interval_in_hours
    }
  }

  tags = local.mssql_database[each.key].tags
}

resource "azurerm_mssql_virtual_network_rule" "mssql_virtual_network_rule" {
  for_each = var.mssql_virtual_network_rule

  name                                 = local.mssql_virtual_network_rule[each.key].name == "" ? each.key : local.mssql_virtual_network_rule[each.key].name
  server_id                            = local.mssql_virtual_network_rule[each.key].server_id
  subnet_id                            = local.mssql_virtual_network_rule[each.key].subnet_id
  ignore_missing_vnet_service_endpoint = local.mssql_virtual_network_rule[each.key].ignore_missing_vnet_service_endpoint
}

resource "azurerm_mssql_firewall_rule" "mssql_firewall_rule" {
  for_each = var.mssql_firewall_rule

  name             = local.mssql_firewall_rule[each.key].name == "" ? each.key : local.mssql_firewall_rule[each.key].name
  server_id        = local.mssql_firewall_rule[each.key].server_id
  start_ip_address = local.mssql_firewall_rule[each.key].start_ip_address
  end_ip_address   = local.mssql_firewall_rule[each.key].end_ip_address
}
