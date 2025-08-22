
variable "prefix" {
  description = "The prefix which should be used for all resources"
  default  = "ars"
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
  default = "North Europe"
}

variable "admin_password" {
  description = "Admin password for postgresSQL db"
  type        = string
  sensitive   = true
}

variable "admin_username" {
  description = "Admin username for postgresSQL db"
  type        = string
  sensitive   = true
} 
