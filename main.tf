terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.57.0"
    }
  }
}

provider "google" {
  project = "playground-s-11-557eb922"
  region = "us-central1"
  zone = "us-central1-c"
}

resource "google_storage_bucket" "gcb"{
    name = "bucket-for-testing-09"
    location = "us-central1"
}