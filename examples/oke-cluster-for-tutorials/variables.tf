### Common variables
variable "compartment_id" {
  description = "コンパートメント OCID"
}
variable "region" {
  description = "リージョン識別子 (e.g. ap-tokyo-1, ap-osaka-1, etc.)"
}

### VCN variables
variable "cidr_block_all" {
  default = "0.0.0.0/0"
  description = "All CIDR Block"
}
variable "cidr_block_vcn" {
  default     = "10.0.0.0/16"
  description = "VCN に割り当てる CIDR Block"
}
variable "cidr_block_node_pool_subnet" {
  default = "10.0.10.0/24"
  description = "ノードプールに割り当てる CIDR Block"
}
variable "cidr_block_k8s_api_endpoint_subnet" {
  default = "10.0.0.0/28"
  description = "Kubernetes API Endpoint に割り当てる CIDR Block"
}
variable "cidr_block_lb_subnet" {
  default = "10.0.20.0/24"
  description = "Service:LoadBalancer に割り当てる CIDR Block"
}
variable "protocol_all" {
  default = "all"
  description = "Protocol for ALL"
}
variable "protocol_icmp" {
  default = "1"
  description = "Protocol number for ICMP"
}
variable "protocol_tcp" {
  default = "6"
  description = "Protocol number for TCP"
}
variable "services_network" {
  default     = "all-nrt-services-in-oracle-services-network"
  description = "Oracle Service Network でサポートするすべてのサービスの CIDR"
}
variable "subnet_prohibit_public_ip_on_vnic" {
  default     = "true"
  description = "パブリック IP の割り当てを無効化"
}

### OKE Cluster variables
variable "availability_domain_name" {
  default     = ""
  description = "可用性ドメイン名（空の場合は、可用性ドメイン番号の値が採用されます）"
}
variable "availability_domain_number" {
  default     = 1
  description = "可用性ドメイン番号 (1|2|3)"
}
variable "cluster_name" {
  default     = "OKE Handson Cluster"
  description = "OKE クラスタの表示名"
}
variable "kubernetes_version" {
  default     = "v1.25.4"
  description = "Kubernetes のバージョン"
}
variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default     = false
  description = "Kubernetes Dashboard の有効化"
}
variable "cluster_options_add_ons_is_tiller_enabled" {
  default     = false
  description = "tiller の有効化"
}
variable "cluster_options_kubernetes_network_config_pods_cidr" {
  default     = "10.1.0.0/16"
  description = "Pod に割り当てる CIDR"
}
variable "cluster_options_kubernetes_network_config_services_cidr" {
  default     = "10.2.0.0/16"
  description = "Service に割り当てる CIDR"
}
variable "node_pool_initial_node_labels_key" {
  default     = "managedBy"
  description = "ノードプールによって管理されるノードに付与するラベルのキー"
}
variable "node_pool_initial_node_labels_value" {
  default     = "ResourceManager"
  description = "ノードプールによって管理されるノードに付与するラベルの値"
}
variable "node_pool_name" {
  default     = "OKE Handson Node Pool"
  description = "ノードプールの表示名"
}
variable "node_pool_node_image_name" {
  default     = "Oracle-Linux-7.9"
  description = "ノードプール内のインスタンスに使用するイメージ"
}
variable "node_pool_node_shape" {
  default     = "VM.Standard2.1"
  description = "ノードプール内のインスタンスに使用するシェイプ"
}
variable "node_pool_quantity_per_subnet" {
  default     = 1
  description = "サブネットごとに配置するノードプールの数"
}
variable "node_pool_boot_volume_size_in_gbs" {
  default     = "50"
  description = "ノードプール内のインスタンスにアタッチするボリュームの量"
}
variable "node_pool_instance_number" {
  default = 1
  description = "ノードプール中にプロビジョニングするインスタンスの台数"
}