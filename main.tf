# Starting provider configuration
provider "google" {
  project = var.project_id
  region  = var.region
}
# Ending provider configuration

# Starting backend Configuration storing state in GCS
terraform {
  backend "gcs" {
    bucket = var.gcs_bucket_name
    prefix = "terraform/state"
  }
}
# Ending backend Configuration storing state in GCS

# Starting VPC
resource "google_compute_network" "main_vpc" {
  name = "gke-vpc"
  auto_create_subnetworks = false
}
# Ending VPC

# Starting subneting
resource "google_compute_subnetwork" "subnet1" {
  name          = "gke-subnet1"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.main_vpc.id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "gke-subnet2"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.main_vpc.id
  region        = var.region
}
# Ending subneting

# Starting GKE_cluster 
resource "google_container_cluster" "gke_cluster" {
  name               = "gke-cluster"
  location           = var.region
  network            = google_compute_network.main_vpc.self_link
  subnetwork         = google_compute_subnetwork.subnet1.self_link
  remove_default_node_pool = true
}
# Ending GKE_cluster

# Starting Node_Pool_1
resource "google_container_node_pool" "node_pool1" {
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  name       = "node-pool-1"
  initial_node_count = 3
  node_config {
    machine_type = "e2-medium"
  }
}
# Ending Node_Pool_1

# Starting Node_Pool_2
resource "google_container_node_pool" "node_pool2" {
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  name       = "node-pool-2"
  initial_node_count = 3
  node_config {
    machine_type = "e2-standard-4"
  }
}
# Ending Node_Pool_2

# Starting Variables
variable "project_id" {}
variable "region" {}
variable "gcs_bucket_name" {}
# Ending Variables



