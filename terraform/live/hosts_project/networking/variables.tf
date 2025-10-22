variable "project_id_host" {
  description = "The project ID of the host project."
  type        = string
}

variable "network_name" {
  description = "The name for the Shared VPC host network."
  type        = string
}

variable "subnets" {
  description = "A map of subnetwork configurations for the Shared VPC."
  type = map(object({
    ip_cidr_range = string
    region        = string
  }))
  # Set an empty default to allow the user to provide the entire map
  default = {}
}