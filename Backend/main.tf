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
    index_document = "../Frontend/index.html"
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
}