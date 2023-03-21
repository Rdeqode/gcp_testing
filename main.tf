
module "storage" {
  source      = "./modules/storage"
  bucket_name = "bucket-for-testing-03"
  location    = "us-central1"
}


module "mig" {
  source           = "./modules/mig"
  project_name     = "playground-s-11-9e6c6f56"
  machine_type     = "e2-micro"
  disk_auto_delete = true
}




