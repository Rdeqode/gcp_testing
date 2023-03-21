resource "google_storage_bucket" "gcb"{
    name = var.bucket_name
    location = var.location
}