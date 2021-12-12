# defines the settings for the resource group, which everything will go into.
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name_prefix}-${var.environment}"
  location = var.location
}
