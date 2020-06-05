data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "external" "test_client_ip" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}
