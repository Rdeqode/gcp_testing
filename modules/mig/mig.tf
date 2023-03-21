data "google_compute_image" "my_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_instance_template" "default" {
  project     = var.project_name
  name_prefix = "default-"

  machine_type = var.machine_type


  disk {
    auto_delete  = var.disk_auto_delete
    boot         = true
    source_image = data.google_compute_image.my_image.self_link
    type         = "PERSISTENT"
    disk_size_gb = var.disk_size_gb
  }

  lifecycle {
    create_before_destroy = true
  }

  network_interface {
    network = "default"
  }
}


resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name               = "instance-group-manager"
  base_instance_name = "instance-name"
 version {
    instance_template  = google_compute_instance_template.default.id
  }
  region             = var.region
  target_size        = "1"
}
