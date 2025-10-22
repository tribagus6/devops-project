variable "host_project_id" {
  description = "The ID of the project where the VPC will be created."
  type        = string
}

variable "network_name" {
  description = "The name of the Shared VPC."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet to share."
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR range for the subnet."
  type        = string
}

variable "region" {
  description = "The region for the subnet."
  type        = string
}

variable "service_projects" {
  description = "A list of service project IDs to attach to the Shared VPC."
  type        = list(string)
}