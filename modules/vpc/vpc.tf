resource "google_compute_network" "vpc" {
  project                 = var.project_name
  name                    = var.mig_vpc_name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "mig_subnet" {
  name          = var.mig_subnet_name
  ip_cidr_range = "10.2.0.0/16"
  #   region        = var.vpc_region_name
  network = google_compute_network.vpc.id

}