variable "mysql_flexible_server" {
  type        = any
  default     = {}
  description = "Resource definition, default settings are defined within locals and merged with var settings. For more information look at [Outputs](#Outputs)."
}

locals {
  default = {
    mysql_flexible_server = {
      name = ""
      tags = {}
    }
  }

  /**
    compare and merge custom and default values
  */
  tpl_local_name_values = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(local.default.mysql_flexible_server, var.mysql_flexible_server[mysql_flexible_server])
  }

  /**
    deep merge of all custom and default values
  */
  mysql_flexible_server = {
    for mysql_flexible_server in keys(var.mysql_flexible_server) :
    mysql_flexible_server => merge(
      local.tpl_local_name_values[mysql_flexible_server],
      {}
    )
  }
}
