resource "google_compute_network" "vpc" {
  name                    = "ceevee-n8n-vpc-${var.environment}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  name          = "ceevee-n8n-private-${var.environment}"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "public" {
  name          = "ceevee-n8n-public-${var.environment}"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Create Serverless VPC connector
resource "google_vpc_access_connector" "connector" {
  name          = "ceevee-n8n-vpc-con-${var.environment}"
  ip_cidr_range = var.vpc_connector_cidr
  network       = google_compute_network.vpc.name
  region        = var.region

  # Standard-tier connector with minimal number of instances
  machine_type  = var.vpc_connector_machine_type
  min_instances = var.vpc_connector_min_instances
  max_instances = var.vpc_connector_max_instances
}

# Create Cloud Router for NAT
resource "google_compute_router" "router" {
  name    = "ceevee-n8n-router-${var.environment}"
  region  = var.region
  network = google_compute_network.vpc.id
}

# Create Cloud NAT
resource "google_compute_router_nat" "nat" {
  name                               = "ceevee-n8n-nat-${var.environment}"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}