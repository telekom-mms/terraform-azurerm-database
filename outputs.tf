output "mysql_flexible_server" {
  description = "Outputs all attributes of resource_type."
  value = {
    for mysql_flexible_server in keys(azurerm_mysql_flexible_server.mysql_flexible_server) :
    mysql_flexible_server => {
      for key, value in azurerm_mysql_flexible_server.mysql_flexible_server[mysql_flexible_server] :
      key => value
    }
  }
}

output "mysql_flexible_server_configuration" {
  description = "Outputs all attributes of resource_type."
  value = {
    for mysql_flexible_server_configuration in keys(azurerm_mysql_flexible_server_configuration.mysql_flexible_server_configuration) :
    mysql_flexible_server_configuration => {
      for key, value in azurerm_mysql_flexible_server_configuration.mysql_flexible_server_configuration[mysql_flexible_server_configuration] :
      key => value
    }
  }
}

output "mysql_flexible_database" {
  description = "Outputs all attributes of resource_type."
  value = {
    for mysql_flexible_database in keys(azurerm_mysql_flexible_database.mysql_flexible_database) :
    mysql_flexible_database => {
      for key, value in azurerm_mysql_flexible_database.mysql_flexible_database[mysql_flexible_database] :
      key => value
    }
  }
}

output "mysql_flexible_server_firewall_rule" {
  description = "Outputs all attributes of resource_type."
  value = {
    for mysql_flexible_server_firewall_rule in keys(azurerm_mysql_flexible_server_firewall_rule.mysql_flexible_server_firewall_rule) :
    mysql_flexible_server_firewall_rule => {
      for key, value in azurerm_mysql_flexible_server_firewall_rule.mysql_flexible_server_firewall_rule[mysql_flexible_server_firewall_rule] :
      key => value
    }
  }
}

output "mysql_flexible_server_active_directory_administrator" {
  description = "Outputs all attributes of resource_type."
  value = {
    for mysql_flexible_server_active_directory_administrator in keys(azurerm_mysql_flexible_server_active_directory_administrator.mysql_flexible_server_active_directory_administrator) :
    mysql_flexible_server_active_directory_administrator => {
      for key, value in azurerm_mysql_flexible_server_active_directory_administrator.mysql_flexible_server_active_directory_administrator[mysql_flexible_server_active_directory_administrator] :
      key => value
    }
  }
}

output "postgresql_flexible_server" {
  description = "Outputs all attributes of resource_type."
  value = {
    for postgresql_flexible_server in keys(azurerm_postgresql_flexible_server.postgresql_flexible_server) :
    postgresql_flexible_server => {
      for key, value in azurerm_postgresql_flexible_server.postgresql_flexible_server[postgresql_flexible_server] :
      key => value
    }
  }
}

output "postgresql_flexible_server_configuration" {
  description = "Outputs all attributes of resource_type."
  value = {
    for postgresql_flexible_server_configuration in keys(azurerm_postgresql_flexible_server_configuration.postgresql_flexible_server_configuration) :
    postgresql_flexible_server_configuration => {
      for key, value in azurerm_postgresql_flexible_server_configuration.postgresql_flexible_server_configuration[postgresql_flexible_server_configuration] :
      key => value
    }
  }
}

output "postgresql_flexible_server_database" {
  description = "Outputs all attributes of resource_type."
  value = {
    for postgresql_flexible_server_database in keys(azurerm_postgresql_flexible_server_database.postgresql_flexible_server_database) :
    postgresql_flexible_server_database => {
      for key, value in azurerm_postgresql_flexible_server_database.postgresql_flexible_server_database[postgresql_flexible_server_database] :
      key => value
    }
  }
}

output "postgresql_flexible_server_firewall_rule" {
  description = "Outputs all attributes of resource_type."
  value = {
    for postgresql_flexible_server_firewall_rule in keys(azurerm_postgresql_flexible_server_firewall_rule.postgresql_flexible_server_firewall_rule) :
    postgresql_flexible_server_firewall_rule => {
      for key, value in azurerm_postgresql_flexible_server_firewall_rule.postgresql_flexible_server_firewall_rule[postgresql_flexible_server_firewall_rule] :
      key => value
    }
  }
}

output "variables" {
  description = "Displays all configurable variables passed by the module. __default__ = predefined values per module. __merged__ = result of merging the default values and custom values passed to the module"
  value = {
    default = {
      for variable in keys(local.default) :
      variable => local.default[variable]
    }
    merged = {
      mysql_flexible_server = {
        for key in keys(var.mysql_flexible_server) :
        key => local.mysql_flexible_server[key]
      }
      mysql_flexible_server_configuration = {
        for key in keys(var.mysql_flexible_server_configuration) :
        key => local.mysql_flexible_server_configuration[key]
      }
      mysql_flexible_database = {
        for key in keys(var.mysql_flexible_database) :
        key => local.mysql_flexible_database[key]
      }
      mysql_flexible_server_firewall_rule = {
        for key in keys(var.mysql_flexible_server_firewall_rule) :
        key => local.mysql_flexible_server_firewall_rule[key]
      }
      mysql_flexible_server_active_directory_administrator = {
        for key in keys(var.mysql_flexible_server_active_directory_administrator) :
        key => local.mysql_flexible_server_active_directory_administrator[key]
      }
      postgresql_flexible_server = {
        for key in keys(var.postgresql_flexible_server) :
        key => local.postgresql_flexible_server[key]
      }
      postgresql_flexible_server_configuration = {
        for key in keys(var.postgresql_flexible_server_configuration) :
        key => local.postgresql_flexible_server_configuration[key]
      }
      postgresql_flexible_server_database = {
        for key in keys(var.postgresql_flexible_server_database) :
        key => local.postgresql_flexible_server_database[key]
      }
      postgresql_flexible_server_firewall_rule = {
        for key in keys(var.postgresql_flexible_server_firewall_rule) :
        key => local.postgresql_flexible_server_firewall_rule[key]
      }
    }
  }
}
