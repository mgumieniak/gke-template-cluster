# https://www.terraform.io/docs/providers/google/r/container_cluster.html#example-usage-with-a-separately-managed-node-pool-recommended-

resource "google_container_cluster" "primary" {
  provider = google

  name     = var.gke_cluster_name
  location = var.regional ? var.region : var.zone

  # Can be single or multi-zone, as
  # https://www.terraform.io/docs/providers/google/r/container_cluster.html#node_locations
  node_locations = var.node_locations

  enable_shielded_nodes = var.enable_shielded_nodes
  enable_tpu            = var.enable_tpu

  network    = google_compute_network.k8s_vpc.id
  subnetwork = google_compute_subnetwork.k8s_subnet.id

  # ip_allocation_policy left empty here to let GCP pick
  # otherwise you will have to define your own secondary CIDR ranges
  # which I will probably look to add at a later date
  networking_mode = var.networking_mode
  ip_allocation_policy {
    cluster_secondary_range_name  = "pod-ranges"
    services_secondary_range_name = "services-range"
  }

  # https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr#cidr_ranges_for_clusters
  default_max_pods_per_node = var.max_pods_per_node

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "Allow only for my IP"
      cidr_block   = var.master_authorized_network_cidr
    }
  }

  # there are cluster sizing requirements if network policy is to be enabled
  # https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy#limitations_and_requirements
  network_policy {
    enabled = var.network_policy_enabled
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  release_channel {
    channel = var.channel
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = var.http_lb_disabled
    }
  }
}


resource "google_container_node_pool" "primary_preemptible_nodes" {
  name     = "preempt-pool"
  location = var.regional ? var.region : var.zone
  cluster  = google_container_cluster.primary.name

  initial_node_count = var.initial_node_count
  autoscaling {
    min_node_count = var.min_nodes
    max_node_count = var.max_nodes
  }

  management {
    auto_repair  = true
    auto_upgrade = var.auto_upgrade
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    dynamic "taint" {
      for_each = var.taint
      content {
        key    = taint.value["key"]
        value  = taint.value["value"]
        effect = taint.value["effect"]
      }
    }
  }
}
