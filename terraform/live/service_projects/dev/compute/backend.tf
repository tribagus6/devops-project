terraform {
  backend "gcs" {
    bucket = "my-unique-terraform-state-bucket-dev"
    prefix = "compute"
  }
}