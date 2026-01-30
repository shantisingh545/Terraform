module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "demo-eks"
  cluster_version = "1.29"
    cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  subnet_ids = ["subnet-0138363cf77405d97", "subnet-0622989dcf5492218"]
  vpc_id     = "vpc-025516a43f0b2a423"

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["t3.medium"]
    }
  }
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}
resource "aws_ecr_repository" "nginx" {
  name = "eks-nginx"
}
