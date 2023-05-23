/**
* # database
*
* This module manages the azurerm database resources.
* For more information see https://registry.terraform.io/providers/azurerm/latest/docs > database
*
*/

resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  for_each = var.mysql_flexible_server

  name = local.mysql_flexible_server[each.key].name == "" ? each.key : local.mysql_flexible_server[each.key].name

  tags = local.mysql_flexible_server[each.key].tags
}
