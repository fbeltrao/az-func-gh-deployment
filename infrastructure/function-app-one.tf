# Storage for the Function
resource "azurerm_storage_account" "function_storage_one" {
  name                     = "stfuncone${var.name_prefix}${var.environment}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = false
}

resource "azurerm_key_vault_secret" "function_storage_one_credentials" {
  name         = "func-one-storage-conn-string"
  value        = azurerm_storage_account.function_storage_one.primary_connection_string
  key_vault_id = azurerm_key_vault.main.id
  depends_on   = [azurerm_key_vault_access_policy.default_policy]

}


resource "azurerm_function_app" "function_app_one" {
  name                      = "func-${var.name_prefix}-one-${var.environment}"
  location                  = azurerm_resource_group.main.location
  resource_group_name       = azurerm_resource_group.main.name
  app_service_plan_id       = azurerm_app_service_plan.main.id
  storage_connection_string = azurerm_storage_account.function_storage_one.primary_connection_string
  version                   = "~3"
  os_type                   = "linux"

  site_config {
    # sets the framework version for Python 3.9
    linux_fx_version = "python|3.9"
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME        = "python"
    AzureWebJobsStorage             = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.main.name};SecretName=${azurerm_key_vault_secret.function_storage_one_credentials.name})"
    APPINSIGHTS_INSTRUMENTATIONKEY  = azurerm_application_insights.main.instrumentation_key
    PYTHON_ENABLE_WORKER_EXTENSIONS = "1"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    MY_SECRET_1                     = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.main.name};SecretName=${azurerm_key_vault_secret.secret_1.name})"
    MY_SECRET_2                     = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.main.name};SecretName=${azurerm_key_vault_secret.secret_2.name})"
    MY_SETTTING                     = var.setting_1
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["WEBSITE_ENABLE_SYNC_UPDATE_SITE"]
    ]
  }
}

resource "azurerm_key_vault_access_policy" "function_app_one" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_function_app.function_app_one.identity.0.principal_id

  secret_permissions = [
    "Get",
    "List",
  ]

  depends_on = [azurerm_key_vault_access_policy.default_policy]
}

