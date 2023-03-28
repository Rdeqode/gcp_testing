
module "mig" {
  source       = "./modules/mig"
  project_name = "playground-s-11-5c784299"
  machine_type = "e2-micro"
  region       = "us-central1"
  subnetwork   = module.vpc.subnetwork_id
}


module "vpc" {
  source          = "./modules/vpc"
  project_name    = "playground-s-11-5c784299"
  mig_vpc_name    = "mig-vpc"
  mig_subnet_name = "mig-subnet"
}



