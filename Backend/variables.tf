variable "resource_group_location" {
  default     = "North Europe"
  description = "Location of the resource group."
}

variable "rg_name" {
  type        = string
  default     = "RG-StaticWebsite"
  description = "Name of the Resource group in which to deploy service objects"
}

variable "storage_account_name" {
  type        = string
  default     = "sastaticwebsite"
  description = "Name of the storage account."
}