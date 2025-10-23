provider "google" {
  project = var.service_project_id
  region  = "asia-east1"
}

# Get data from the host project's remote state
data "terraform_remote_state" "host_project" {
  backend = "gcs"
  config = {
    # !! IMPORTANT: Change the bucket name !!
    bucket = "orca-terraform-state-bucket"
    prefix = "live/hosts_project/networking"
  }
}

# Call the GCE module to create a test VM
module "appbusineess_gce_instance" {
  source = "../../../../modules/gce-instance"

  project_id    = var.service_project_id
  instance_name = "dev-vm-01"
  zone          = "asia-east1-a"
  machine_type  = "e2-medium"
  
  # This is the key part: Use the subnet from the remote state
  subnet_self_link = data.terraform_remote_state.host_project.outputs.subnet_self_links[var.subnet_name]
  
  tags = ["dev", "web"]
}
