
# variables.tf

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "mini-finance-rg"
}

variable "location" {
  description = "Azure region to deploy resources in"
  type        = string
  default     = "UK South"
}

variable "admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
  default     = "azureuser"
}

variable "public_key_path_rsa" {
  description = "Path to your RSA public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}




