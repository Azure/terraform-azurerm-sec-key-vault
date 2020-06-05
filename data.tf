data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "base" {
  name = var.resource_group_name
}
