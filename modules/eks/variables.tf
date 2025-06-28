variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "node_groups" {
  type = any
}
variable "tags" {
  type = map(string)
}

