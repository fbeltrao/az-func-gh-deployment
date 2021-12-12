# The application insights resource allows the function applications to upload their log data for
# future review. 
resource "azurerm_application_insights" "main" {
  name                = "appi-${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "other"
}
