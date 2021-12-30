#-----------------------
# provider variables
#-----------------------
variable "project_id" {}

variable "credentials_file_path" {}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

#------------------------------------------------
# VPC_native cluster networking
# https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips
#------------------------------------------------

variable "primary_ip_cidr" {
  description = "Primary CIDR for nodes."
  default     = "10.128.0.0/20"
}

variable "max_pods_per_node" {
  description = "Max pods per node. By default, GKE allows up to 110 Pods per node on Standard clusters. Autopilot clusters have a maximum of 32 Pods per node."
  default     = "110"
}

variable "cluster_ipv4_cidr_block" {
  description = "Secondary CIDR for pods."
  default     = "10.112.0.0/14"
}

variable "services_ipv4_cidr_block" {
  description = "Secondary CIDR for services."
  default     = "10.116.0.0/20"
}

#-----------------------------
# GKE Cluster
#-----------------------------

variable "gke_cluster_name" {}

variable "regional" {
  description = "Is this cluster regional or zonal? Regional clusters aren't covered by Google's Always Free tier."
  default     = "false"
}

variable "node_locations" {
  type    = list(string)
  default = []
}

variable "enable_shielded_nodes" {
  description = "Shielded GKE nodes provide strong cryptographic identity for nodes joining a cluster.  Will be default with version 1.18+"
  default     = "true"
}

variable "enable_tpu" {
  description = "Whether to enable Cloud TPU resources in this cluster.  TPUs are Tensor Processing Units used for machine learning."
  default     = "false"
}

# VPC_NATIVE is recommended
variable "networking_mode" {
  description = "Determines whether alias IPs or routes are used for pod IPs in the cluster.  ip_allocation_policy block needs to be defined if using VPC_NATIVE.  Accepted values are VPC_NATIVE or ROUTES."
  default     = "VPC_NATIVE"
}

variable "enable_private_endpoint" {
  description = "When true public access to cluster (master) endpoint is disabled.  When false, it can be accessed both publicly and privately."
  default     = "true"
}

variable "enable_private_nodes" {
  description = "Nodes only have private IPs and communicate to master via private networking."
  default     = "true"
}

variable "master_authorized_network_cidr" {
  description = "External networks that can access the Kubernetes cluster master through HTTPS.  The default is to allow all (not recommended for production)."
  default     = "0.0.0.0/0"
}

variable "master_ipv4_cidr_block" {
  description = "CIDR of the master network. Range must not overlap with any other ranges in use within the cluster's network."
  default     = ""
}

variable "network_policy_enabled" {
  description = "If enabled, allows GKE's network policy enforcement to control communication between cluster's pods and services."
  default     = "false"
}
variable "channel" {
  description = "The channel to get the k8s release from. Accepted values are UNSPECIFIED, RAPID, REGULAR and STABLE"
  default     = "UNSPECIFIED"
}

variable "http_lb_disabled" {
  description = "If enabled, a controller will be installed to coordinate applying load balancing configuration changes to your GCP project."
  default     = "false"
}

#-----------------------------
# GKE Node Pool
#-----------------------------

variable "machine_type" {
  default = "e2-standard-2"
}

variable "disk_size_gb" {
  description = "The default disk size the nodes are given.  100G is probably too much for a test cluster, so you can change it if you'd like.  Don't set it too low though as disk I/O is also tied to disk size."
  default     = "20"
}

variable "initial_node_count" {
  default = "2"
}

variable "min_nodes" {
  default = "2"
}

variable "max_nodes" {
  default = "5"
}

variable "auto_upgrade" {
  description = "Enables auto-upgrade of cluster.  Needs to be 'true' unless 'channel' is UNSPECIFIED"
  default     = "false"
}
