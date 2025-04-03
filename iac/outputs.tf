output "n8n_url" {
  description = "The URL of the deployed n8n service"
  value       = module.n8n.service_url
}

output "database" {
  description = "The instance name"
  value       = module.database.instance_name
}

output "browserless_url" {
  description = "The URL of the deployed browserless service"
  value       = module.browserless.service_url
}

output "instance_name" {
  description = "The name of the database instance"
  value       = module.database.instance_name
}

output "database_host" {
  description = "The host address of the database"
  value       = module.database.database_host
}

output "n8n_database_name" {
  description = "The name of the N8N database"
  value       = module.database.n8n_database_name
}
