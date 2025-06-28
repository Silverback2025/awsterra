cluster_name    = "dev-eks"
cluster_version = "1.29"
vpc_id          = "vpc-12345678"
subnet_ids      = ["subnet-abc", "subnet-def"]

node_groups = {
  default = {
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1
    instance_types   = ["t3.medium"]
  }
}

tags = {
  Environment = "dev"
  Terraform   = "true"
}
