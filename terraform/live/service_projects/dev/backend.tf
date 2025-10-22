# This backend configuration is inherited by child directories.
# You must create the GCS bucket before running terraform init.
terraform {
  backend "gcs" {
    bucket = "my-unique-terraform-state-bucket-dev"
    prefix = "dev"
  }
}