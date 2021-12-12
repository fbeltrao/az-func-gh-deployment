# This is the App Service Plan. Azure Function apps require an app service plan, to define the 
# underlying compute resources that the functions will run on. 
resource "azurerm_app_service_plan" "main" {
  name                = "plan-${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
