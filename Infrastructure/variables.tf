variable "arm_subscription_id" {
  description = "The subscription ID to deploy the resources"

}

variable "arm_client_id" {
  description = "The client ID of the service principal"

}

variable "arm_tenant_id" {
  description = "The tenant ID of the service principal"

}

variable "project_location" {
  default     = "North Europe"
  description = "Location of project resources."
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

variable "app_service_plan_name" {
  type        = string
  default     = "appserviceplan"
  description = "Name of the app service plan."

}

variable "functionapp_name" {
  type        = string
  default     = "functionapp982301"
  description = "Name of the function app."

}

variable "cosmos_account_name" {
  type        = string
  default     = "cosmosdb"
  description = "Name of the cosmosdb account."

}

variable "cosmos_db_name" {
  type        = string
  default     = "cosmosdb"
  description = "Name of the cosmosdb account."

}

