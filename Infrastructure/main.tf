# Creation of the RG for the static website
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.resource_group_location
}

# Creation of the storage account for the static website
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document = "index.html"
  }
}

# Creation of the storage blob for the static website
resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  storage_account_name   = var.storage_account_name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "../Frontend/index.html"
  depends_on             = [azurerm_storage_account.sa]
}


# Creation of the app service plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
# Creation of azure function app
resource "azurerm_function_app" "functionapp" {
  name                       = var.functionapp_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.appserviceplan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  version                    = "~4"
}