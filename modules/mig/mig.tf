data "google_compute_image" "my_image" {
  family  = var.instance_family
  project = var.instance_project
}

resource "google_compute_instance_template" "default" {
  project      = var.project_name
  name_prefix  = "instance-template-"
  machine_type = var.machine_type

  disk {
    auto_delete  = true
    boot         = true
    source_image = data.google_compute_image.my_image.self_link
  }

  lifecycle {
    create_before_destroy = true
  }

  network_interface {
    network = "default"
  }
}


resource "google_compute_region_instance_group_manager" "region_instance_group_manager" {
  description        = "terraform instance group manager"
  name               = "regional-instance-group-manager"
  base_instance_name = "instance-name"
  version {
    instance_template = google_compute_instance_template.default.self_link
  }
  region                           = var.region

  distribution_policy_target_shape = "BALANCED"
 update_policy {
    type                         = "PROACTIVE"
    instance_redistribution_type = "NONE"
    minimal_action               = "REPLACE"
    max_unavailable_fixed        = 3
    replacement_method           = "RECREATE"
    most_disruptive_allowed_action = "REPLACE"
  }


}

resource "google_compute_region_disk" "regiondisk" {
  count = var.target_instances
  name          = "regional-disk-${count.index}"
  type          = "pd-ssd"
  region        = "us-central1"
  replica_zones = ["us-central1-c", "us-central1-f"]
  size =2
}


resource "google_compute_region_per_instance_config" "with_disk" {
  count =var.target_instances
  #  region= var.region
  region_instance_group_manager  = google_compute_region_instance_group_manager.region_instance_group_manager.name
  name= "instance-name-test2-${count.index}"
  most_disruptive_allowed_action = "REPLACE"


 preserved_state {
    # metadata = {
    #   // Adding a reference to the instance template used causes the stateful instance to update
    #   // if the instance template changes. Otherwise there is no explicit dependency and template
    #   // changes may not occur on the stateful instance
    #   instance_template = google_compute_instance_template.default.self_link
    # }

    disk {
      device_name = "my-stateful-disk-${count.index}"
      source      = google_compute_region_disk.regiondisk[count.index].id
      mode        = "READ_WRITE"
      delete_rule = "NEVER"
    }
  }
}