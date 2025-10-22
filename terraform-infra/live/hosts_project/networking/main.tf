variable "host_project_id" { type = string }
variable "service_projects" { type = list(string) }
variable "gcp_region" { type = string }

provider "google" {
  project = var.host_project_id
}

module "shared_vpc" {
  source = "../../../modules/shared-vpc-host"

  host_project_id   = var.host_project_id
  service_projects  = var.service_projects
  region            = var.gcp_region
  network_name      = "shared-main-vpc"
  subnet_name       = "shared-main-subnet"
  subnet_cidr       = "10.20.0.0/24"
}