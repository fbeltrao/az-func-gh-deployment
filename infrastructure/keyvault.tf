data "azurerm_client_config" "current" {}

# Key vault enables the storage and retrival of secrets in a secure manner.
resource "azurerm_key_vault" "main" {
  name                = "kv-${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}


resource "azurerm_key_vault_secret" "secret_1" {
  name         = "secret-1"
  value        = var.secret_1
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [
    azurerm_key_vault_access_policy.terraform_client
  ]
}

resource "azurerm_key_vault_secret" "secret_2" {
  name         = "secret-2"
  value        = var.secret_2
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [
    azurerm_key_vault_access_policy.terraform_client
  ]
}

# Create a Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  secret_permissions = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}