provider "google" {
  project = var.project_id
  region  = "asia-east1"
}

data "terraform_remote_state" "host_project" {
  backend = "gcs"
  config = {
    # !! IMPORTANT: Change the bucket name !!
    bucket = "orca-terraform-state-bucket"
    prefix = "live/hosts_project/networking"
  }
}

module "firewall_rules" {
  source = "../../../../modules/vpc-firewall-rules"

  project_id   = var.project_id
  network_name = data.terraform_remote_state.host_project.outputs.vpc_network_name # Get network name from the VPC module
  
  firewall_rules = var.firewall_rules
}