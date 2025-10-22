terraform {
  backend "gcs" {
    bucket = "my-unique-terraform-state-bucket-host" # A dedicated bucket for host state
    prefix = "networking"
  }
}