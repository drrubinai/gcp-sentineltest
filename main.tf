# Terraform configuration
terraform {
  backend "remote" {
    organization = "epam092020"
    workspaces {
      name = "epam-gcp-template-gce"
    }
  }
}

variable "gcp_project" {
  description = "my GCP project"
}
  
variable "machine_type" {
  description = "my GCP machine type"
  default = "n1-standard-1"
}

variable "instance_name" {
  description = "my GCP instance name"
  default = "demo"
}

variable "image" {
   description = "GCP image"
   default = "debian-cloud/debian-9"
}

provider "google" {
   project = "${var.gcp_project}"
   region = "us-east1"
}

resource "google_compute_instance" "demo" {
   name          = "${var.instance_name}"
   machine_type  = "${var.machine_type}"
   zone          = "us-east1-b"
   
   boot_disk {
      initialize_params {
	      image  = "${var.image}"
	  }
   }
   
   network_interface {
       network = "default"
	   
	   access_config {
	      // Ephemeral IP
	   }
   }
}