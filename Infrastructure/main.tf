# Creation of the RG for the static website
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.project_location
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
  kind                = "Linux"
  reserved            = true
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
  os_type                    = "linux"
  version                    = "~3"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"]
    ]
  }
}


# Creating a Cosmos DB Account
resource "azurerm_cosmosdb_account" "cosmosaccount" {
  name                = var.cosmos_account_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  depends_on = [
    azurerm_resource_group.rg
  ]
}

# Creating a Cosmos DB SQL API Database
resource "azurerm_cosmosdb_sql_database" "cosmosdb" {
  name                = var.cosmos_db_name
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosaccount.name
  throughput          = 400
  depends_on = [
    azurerm_cosmosdb_account.cosmosaccount
  ]
}
/*
# Creating a Cosmos DB SQL API Container
resource "azurerm_cosmosdb_sql_container" "cosmoscontainer" {
  name                = var.cosmos_container_name
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosaccount.name
  database_name       = azurerm_cosmosdb_sql_database.cosmosdb.name
  partition_key_path  = "/id"
  throughput          = 400
  depends_on = [
    azurerm_cosmosdb_sql_database.cosmosdb
  ]
}
*/