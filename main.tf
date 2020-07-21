provider "azurerm" {
  version = "~>2.0"
  features {}
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
  suffix = var.suffix
  prefix = var.prefix
}

resource "azurerm_key_vault" "key_vault" {
  name                            = module.naming.key_vault.name_unique
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  tenant_id                       = data.azurerm_subscription.current.tenant_id
  soft_delete_enabled             = true
  purge_protection_enabled        = true
  sku_name                        = var.sku_name

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.permitted_virtual_network_subnet_ids
  }

  depends_on = [null_resource.module_depends_on]
}

resource "null_resource" "module_depends_on" {
  triggers = {
    value = "${length(var.module_depends_on)}"
  }
}
