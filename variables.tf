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
  default     = "this_akv"
  type        = string
  description = "Keeper for the akv random postfix."
}
