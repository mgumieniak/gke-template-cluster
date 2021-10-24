resource "google_compute_network" "k8s_vpc" {
  name = "${var.gke_cluster_name}-k8s-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s_subnet" {
  name                     = "${var.gke_cluster_name}-subnet"
  ip_cidr_range            = var.primary_ip_cidr
  network                  = google_compute_network.k8s_vpc.id
  private_ip_google_access = "true"
  region                   = var.region

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.services_ipv4_cidr_block
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.cluster_ipv4_cidr_block
  }

}
