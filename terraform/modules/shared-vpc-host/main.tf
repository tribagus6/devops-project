# Enable necessary APIs
resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

# Create the VPC network
resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"

  depends_on = [
    google_project_service.compute
  ]
}

# Create subnets
resource "google_compute_subnetwork" "subnets" {
  for_each = var.subnets

  project                  = var.project_id
  name                     = each.key
  ip_cidr_range            = each.value.ip_cidr_range
  region                   = each.value.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

# Enable the project as a Shared VPC Host
resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project_id
  # Wait for the network and subnets to be ready
  depends_on = [
    google_compute_subnetwork.subnets
  ]
}