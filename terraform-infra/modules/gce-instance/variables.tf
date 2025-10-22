variable "instance_name" {
  description = "The name of the GCE instance."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the instance."
  type        = string
  default     = "e2-small"
}

variable "zone" {
  description = "The zone for the instance."
  type        = string
}

variable "network" {
  description = "The VPC network to attach the VM to."
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to attach the VM to."
  type        = string
}