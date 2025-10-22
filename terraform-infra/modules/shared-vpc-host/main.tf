# 1. Create the VPC and Subnet as usual
resource "google_compute_network" "main" {
  project                 = var.host_project_id
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  project       = var.host_project_id
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.main.id
}

# 2. Enable the project as a Shared VPC Host
resource "google_compute_shared_vpc_host_project" "host" {
  project = var.host_project_id
}

# 3. Attach the Service Projects to the Host Project
resource "google_compute_shared_vpc_service_project" "service_project_attachment" {
  for_each       = toset(var.service_projects)
  host_project   = google_compute_shared_vpc_host_project.host.project
  service_project = each.key
}

# 4. Grant service accounts from the service projects access to use the subnet
# This is the key permission that allows VMs to be created in the subnet.
resource "google_compute_subnetwork_iam_member" "network_user_binding" {
  for_each    = toset(var.service_projects)
  project     = var.host_project_id
  region      = var.region
  subnetwork  = google_compute_subnetwork.main.name
  role        = "roles/compute.networkUser"
  member      = "serviceAccount:${data.google_project.service_project[each.key].number}@cloudservices.gserviceaccount.com"
  depends_on  = [google_compute_shared_vpc_service_project.service_project_attachment]
}

data "google_project" "service_project" {
  for_each  = toset(var.service_projects)
  project_id = each.key
}