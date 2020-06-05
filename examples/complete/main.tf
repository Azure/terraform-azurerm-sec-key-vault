provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "random_string" "resource_group_name_prefix" {
  length    = 5
  special   = false
  lower     = true
  min_lower = 5
}

resource "azurerm_resource_group" "test_group" {
  name     = "rg-key-vault-full-test-${random_string.resource_group_name_prefix.result}"
  location = "uksouth"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-key-vault-test"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.test_group.location
  resource_group_name = azurerm_resource_group.test_group.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-key-vault-test"
  resource_group_name  = azurerm_resource_group.test_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.2.0/24"
  service_endpoints    = ["Microsoft.KeyVault"]
}

module "terraform-azurerm-key-vault" {
  source                               = "../"
  resource_group_name                  = azurerm_resource_group.test_group.name
  prefix                               = [random_string.resource_group_name_prefix.result]
  suffix                               = [random_string.resource_group_name_prefix.result]
  allowed_ip_ranges                    = [data.external.test_client_ip.result.ip]
  permitted_virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
  sku_name                             = "standard"
  enabled_for_deployment               = true
  enabled_for_disk_encryption          = true
  enabled_for_template_deployment      = true
}
