# !! IMPORTANT: Change the bucket name !!
terraform {
  backend "gcs" {
    bucket = "orca-terraform-state-bucket"
    prefix = "live/service_projects/dev/compute"
  }
}
