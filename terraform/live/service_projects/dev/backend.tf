# !! IMPORTANT: Change the bucket name !!
terraform {
  backend "gcs" {
    bucket = "my-terraform-state-bucket"
    prefix = "live/service_projects/dev/networking"
  }
}
