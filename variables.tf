variable "prefix" {
  type        = string
  default     = "akvpoc"
  description = "Prefix to use for naming."
}

variable "location" {
  default     = "eastus"
  type        = string
  description = "Location to use for the deployment."
}

variable "akv_prefix" {
  default     = "regen"
  type        = string
  description = "Keeper for the akv random postfix. Update value to generate new names."
}

# Begin Key Vault Variables
variable "admin_key_permissions" {
  type        = list(any)
  default     = ["Get", "List", "Delete", "Purge", "Update", "Create", "Import", "Recover", "Backup", "Restore", "GetRotationPolicy", "SetRotationPolicy", "Rotate", "Encrypt", "Decrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Release", ]
  description = "Admin Level Key Vault Permissions for Keys."
}

variable "admin_secret_permissions" {
  type        = list(any)
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set", ]
  description = "Admin Level Key Vault Permissions for Secrets."
}

variable "admin_storage_permissions" {
  type        = list(any)
  default     = ["Get", "List", "Set", "Delete", "Purge", ]
  description = "Admin Level Key Vault Permissions for Storage."
}

variable "admin_certificate_permissions" {
  type        = list(any)
  default     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge", ]
  description = "Admin Level Key Vault Permissions for Certificate."
}

variable "aad_key_permissions" {
  type        = list(any)
  default     = ["Get", "List", ]
  description = "AAD Level Key Vault Permissions for Keys."
}

variable "aad_secret_permissions" {
  type        = list(any)
  default     = ["Get", "List", "Set", ]
  description = "AAD Level Key Vault Permissions for Secrets."
}

variable "aad_storage_permissions" {
  type        = list(any)
  default     = ["Get", "List", "Set", ]
  description = "AAD Level Key Vault Permissions for Storage."
}

variable "aad_certificate_permissions" {
  type        = list(any)
  default     = ["Get", "List", "Update", "Create", "Import", ]
  description = "AAD Level Key Vault Permissions for Certificate."
}