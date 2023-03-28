variable "instance_family" {
  description = "latest image name"
  default     = "debian-11"
}

variable "instance_project" {
  description = "the project in which resource belongs"
  default     = "debian-cloud"

}


variable "project_name" {
}

variable "machine_type" {
  description = "Machine type for the VMs in the instance group."
}

variable "region" {
  description = "region for cloud resources."
}


variable "target_instances" {
  description = "target instances in instance group"
  default     = 2

}

variable "instance_group_manager_name" {
  default = "regional-instance-group-manager"

}

variable "base_instance_name" {
  default = "instance-name"

}

variable "subnetwork" {}
