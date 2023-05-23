output "mysql_flexible_server" {
  description = "Outputs all attributes of resource_type."
  value = {
    for mysql_flexible_server in keys(tpl_resource_type.mysql_flexible_server) :
    mysql_flexible_server => {
      for key, value in tpl_resource_type.mysql_flexible_server[mysql_flexible_server] :
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
    }
  }
}
