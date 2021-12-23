project_id            = "gcp-workspace-336017"
credentials_file_path = "~/keys/terraform-ca.json"

channel      = "REGULAR"
auto_upgrade = "true"

gke_cluster_name        = "my-owncloud"
enable_private_endpoint = "false"
enable_private_nodes    = "false"

machine_type = "e2-standard-2"
disk_size_gb = "20"

initial_node_count = "2"