variable "project_id" {
  description = "The project ID to host the Shared VPC."
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

variable "subnets" {
  description = "A map of subnets to create. Key is the subnet name."
  type = map(object({
    ip_cidr_range = string
    region        = string
  }))
  default = {}
}
