provider "google" {
  project = var.service_project_id
  region  = "asia-east1"
}

variable "service_project_id" {
  description = "The project ID of this (dev) service project."
  type        = string
}

# Get data from the host project's state
data "terraform_remote_state" "host_project" {
  backend = "gcs"
  config = {
    # !! IMPORTANT: Change the bucket name !!
    bucket = "my-terraform-state-bucket"
    prefix = "live/hosts_project/networking"
  }
}

# Enable the Compute API on the service project
resource "google_project_service" "compute" {
  project = var.service_project_id
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

# Attach this service project to the host project
resource "google_compute_shared_vpc_service_project" "service_project_attachment" {
  host_project    = data.terraform_remote_state.host_project.outputs.project_id
  service_project = var.service_project_id

  depends_on = [
    google_project_service.compute
  ]
}