output "instance_name" {
  description = "The name of the database instance"
  value       = google_sql_database_instance.instance.name
}

output "database_host" {
  value       = google_sql_database_instance.instance.private_ip_address
  description = "The host address of the database"
}

output "n8n_database_name" {
  value       = google_sql_database.n8n.name
  description = "The name of the N8N database"
}

output "n8n_username_secret_id" {
  value       = google_secret_manager_secret.n8n_username.id
  description = "Secret ID for N8N database username"
}

output "n8n_password_secret_id" {
  value       = google_secret_manager_secret.n8n_password.id
  description = "Secret ID for N8N database password"
}

output "n8n_database_url_secret_id" {
  value       = google_secret_manager_secret.n8n_database_url.id
  description = "Secret ID for N8N database URL"
}
