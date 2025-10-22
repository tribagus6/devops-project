resource "google_compute_instance" "vm" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # This assumes the subnet is a self-link,
    # which is what we get from the host project's remote state.
    subnetwork = var.subnet_self_link
    
    # We leave 'network' blank, as 'subnetwork' is sufficient
    # and handles Shared VPC attachments correctly.

    # Add an access config to get an external IP (optional)
    access_config {
    }
  }

  service_account {
    # Use the default compute service account
    email  = "default"
    scopes = ["cloud-platform"]
  }
}