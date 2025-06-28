module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.subnet_ids
  vpc_id          = var.vpc_id

  manage_aws_auth = true
  enable_irsa     = true

  node_groups = var.node_groups

  tags = var.tags
}

