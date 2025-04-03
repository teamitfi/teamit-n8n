terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./modules/vpc"

  project_id  = var.project_id
  region      = var.region
  environment = var.environment
}

module "database" {
  source = "./modules/cloud-sql"

  project_id  = var.project_id
  region      = var.region
  environment = var.environment
  vpc_id      = module.network.vpc_id
  depends_on  = [module.network]
}

module "n8n" {
  source = "./modules/cloud-run-n8n"

  project_id  = var.project_id
  region      = var.region
  environment = var.environment

  database_host               = module.database.database_host
  database_name               = module.database.n8n_database_name
  vpc_connector_name          = module.network.vpc_connector_name
  database_username_secret_id = module.database.n8n_username_secret_id
  database_password_secret_id = module.database.n8n_password_secret_id
  depends_on                  = [module.database, module.network]
}

module "browserless" {
  source                    = "./modules/cloud-run-browserless"
  project_id                = var.project_id
  region                    = var.region
  environment               = var.environment
  n8n_service_account_email = module.n8n.service_account_email

  depends_on = [module.network, module.n8n]
}
