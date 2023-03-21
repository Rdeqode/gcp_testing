
module "storage" {
  source = "./modules/storage"
  bucket_name = "bucket-for-testing-02"
  location = "us-central1"
}


module "mig" {
    source = "./modules/mig"
    
}




