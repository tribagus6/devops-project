variable "project_id" {
  description = "The project ID to deploy the VM into (the service project)."
  type        = string
}

variable "instance_name" {
  description = "The name of the VM instance."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the VM."
  type        = string
  default     = "e2-small"
}

variable "zone" {
  description = "The GCP zone to deploy the VM in."
  type        = string
}

variable "subnet_self_link" {
  description = "The self-link of the subnet to attach to (from the Shared VPC)."
  type        = string
}

variable "image" {
  description = "The boot disk image."
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "tags" {
  description = "A list of network tags to apply to the instance."
  type        = list(string)
  default     = []
}