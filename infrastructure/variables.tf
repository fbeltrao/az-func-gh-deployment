variable "name_prefix" {
  description = "A unique prefix"
  default     = "fbrfunc"
  validation {
    condition     = length(var.name_prefix) >= 3 && length(var.name_prefix) <= 10
    error_message = "The name_prefix length must be between 3 and 10 characters."
  }
}

variable "environment" {
  description = "Short name for the environment"
  default     = "stage"
  type        = string
  validation {
    condition     = contains(["stage", "prod"], var.environment)
    error_message = "The environment must be either stage or prod."
  }
}

variable "location" {
  default = "North Europe"
}

variable "secret_1" {
  description = "A secret"
  sensitive   = true
}

variable "secret_2" {
  description = "A secret"
  sensitive   = true
}

variable "setting_1" {
  description = "A setting"
  default     = "100"
}
