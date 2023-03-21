variable "project_name" {
}

variable "machine_type" {
  description = "Machine type for the VMs in the instance group."
}

variable "disk_auto_delete" {
  description = "Whether or not the disk should be auto-deleted."

}

variable "disk_size_gb" {
  description = "The size of the image in gigabytes. If not specified, it will inherit the size of its base image."
  default     = 0

}

variable "region" {
  description = "Region for cloud resources."
  default     = "us-central1"


}
