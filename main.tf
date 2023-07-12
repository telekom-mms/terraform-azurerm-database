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
    for_each = flatten(compact(values(local.mysql_flexible_server[each.key].customer_managed_key))) == [] ? [] : [0]

    content {
      key_vault_key_id                     = local.mysql_flexible_server[each.key].customer_managed_key.key_vault_key_id
      primary_user_assigned_identity_id    = local.mysql_flexible_server[each.key].customer_managed_key.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = local.mysql_flexible_server[each.key].customer_managed_key.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = local.mysql_flexible_server[each.key].customer_managed_key.geo_backup_user_assigned_identity_id
    }
  }

  dynamic "high_availability" {
    for_each = flatten(compact(values(local.mysql_flexible_server[each.key].high_availability))) == [] ? [] : [0]

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
    for_each = flatten(compact(values(local.mysql_flexible_server[each.key].maintenance_window))) == [] ? [] : [0]

    content {
      day_of_week  = local.mysql_flexible_server[each.key].maintenance_window.day_of_week
      start_hour   = local.mysql_flexible_server[each.key].maintenance_window.start_hour
      start_minute = local.mysql_flexible_server[each.key].maintenance_window.start_minute
    }
  }

  dynamic "storage" {
    for_each = flatten(compact(values(local.mysql_flexible_server[each.key].storage))) == [] ? [] : [0]

    content {
      auto_grow_enabled = local.mysql_flexible_server[each.key].storage.auto_grow_enabled
      iops              = local.mysql_flexible_server[each.key].storage.iops
      size_gb           = local.mysql_flexible_server[each.key].storage.size_gb
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
