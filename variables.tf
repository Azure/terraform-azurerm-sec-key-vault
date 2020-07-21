#Required Variables
variable "resource_group_name" {
  type        = string
  description = "The Resource Group name in which to put the Log Analytics resources"
}

variable "resource_group_location" {
  type        = string
  description = "The Resource Group location in which to put the Log Analytics resources"
}

#Optional Variables
variable "prefix" {
  type        = list(string)
  description = "A naming prefix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "suffix" {
  type        = list(string)
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IP Address CIDR ranges to allow access to the Key Vault."
  default     = []
}

variable "permitted_virtual_network_subnet_ids" {
  type        = list(string)
  description = "List of the Subnet IDs to allow to access to the Key Vault."
  default     = []
}

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "The Name of the SKU used for this Key Vault. Either 'standard' or 'premium'"
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Enable Key Vault to be used in deployment"
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Enable Key Vault to be used in disk encryption"
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Enable Key Vault to be used in ARM templates deployments"
  default     = false
}

variable "module_depends_on" {
  default = [""]
}
