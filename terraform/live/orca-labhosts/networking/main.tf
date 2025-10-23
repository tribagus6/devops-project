provider "google" {
  project = var.project_id
  region  = "asia-east1"
}

# Call the module to create the VPC
module "shared_vpc" {
  source = "../../../modules/shared-vpc-host"

  project_id   = var.project_id
  network_name = var.network_name
  subnets      = var.subnets
}
