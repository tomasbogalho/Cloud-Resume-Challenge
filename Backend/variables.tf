variable "arm_subscription_id" {
  description = "The subscription ID to deploy the resources"

}

variable "arm_client_id" {
  description = "The client ID of the service principal"

}

variable "arm_tenant_id" {
  description = "The tenant ID of the service principal"

}

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
  default     = "sastaticwebsite84851"
  description = "Name of the storage account."
}

