terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Data source to read the outputs from the host project's state file
data "terraform_remote_state" "host_vpc" {
  backend = "gcs"
  config = {
    bucket = "my-unique-terraform-state-bucket-host" # The host project's state bucket
    prefix = "networking"                            # The prefix for the networking state
  }
}

# Call the reusable GCE instance module
module "web_server" {
  source = "../../../../modules/gce-instance"

  # Pass network info from the HOST remote state outputs
  network    = data.terraform_remote_state.host_vpc.outputs.network_name
  subnetwork = data.terraform_remote_state.host_vpc.outputs.subnet_name

  # Define instance-specific variables
  instance_name = "dev-web-server-01"
  machine_type  = "e2-medium"
  zone          = "${var.gcp_region}-b"
}