terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# --------------------
# Resource Group
# --------------------
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg-postgres-demo"
  location = var.location
}

# --------------------
# PostgreSQL Flexible Server
# --------------------
resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "${var.prefix}-pg-flex"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "14"

  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"   # Burstable small SKU
}

# --------------------
# PostgreSQL Database
# --------------------
resource "azurerm_postgresql_flexible_server_database" "appdb" {
  name      = "arspostgresdb"
  server_id = azurerm_postgresql_flexible_server.db.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}

# --------------------
# Output Connection String
# --------------------
output "postgres_connection_string" {
  value = "postgresql://${azurerm_postgresql_flexible_server.db.administrator_login}:${azurerm_postgresql_flexible_server.db.administrator_password}@${azurerm_postgresql_flexible_server.db.fqdn}:5432/${azurerm_postgresql_flexible_server_database.appdb.name}"
#  sensitive = true
}
