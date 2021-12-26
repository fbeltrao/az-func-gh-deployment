output "function_app_one_name" {
  description = "Function app one name"
  value       = azurerm_function_app.function_app_one.name
}

output "function_app_one_key" {
  description = "Function app one key"
  value       = data.azurerm_function_app_host_keys.function_app_one_keys.default_function_key
  sensitive   = true
}
