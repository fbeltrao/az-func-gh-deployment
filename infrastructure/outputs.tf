output "function_app_one_name" {
  description = "Function app one name"
  value       = azurerm_function_app.function_app_one.name
}

output "function_app_one_key" {
  description = "Function app one key"
  value       = function_app_one_keys
  
}