# !! IMPORTANT: Change the bucket name !!
terraform {
  backend "gcs" {
    bucket = "orca-terraform-state-bucket"
    prefix = "live/hosts_project/networking"
  }
}
