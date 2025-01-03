# 引入 IAM 角色與政策，並創建 EKS 叢集所需的角色
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json

  tags = {
    "Name" = "eks-cluster-role"
  }
}

# 設定 EKS 叢集角色的 Assume Role 政策
data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

# 創建附加政策，為 EKS 叢集提供必要的權限
resource "aws_iam_policy" "eks_cluster_policy" {
  name        = "eks-cluster-policy"
  description = "Policy for managing EKS clusters"
  policy      = data.aws_iam_policy_document.eks_cluster_policy.json
}

data "aws_iam_policy_document" "eks_cluster_policy" {
  statement {
    actions = [
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "iam:ListRolePolicies",
      "iam:GetRole",
      "iam:ListAttachedRolePolicies",
      "iam:AttachRolePolicy",
      "eks:DescribeCluster",
      "eks:CreateCluster",
      "eks:UpdateClusterConfig",
      "eks:UpdateClusterVersion"
    ]
    resources = ["*"]
  }
}

# 將 IAM 政策附加到角色
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
  role       = aws_iam_role.eks_cluster_role.name
}

# 使用 terraform-aws-modules/eks/aws 模組創建 EKS 叢集
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.12.1"
  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_version
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    app-nodes = {
      desired_capacity = var.node_group_desired_capacity
      max_capacity     = var.node_group_max_capacity
      min_capacity     = var.node_group_min_capacity

      instance_type = var.instance_type
      key_name      = var.key_name

      tags = {
        "Name" = "app-nodes"
      }
    }
  }

  # 新增 IAM 角色給 EKS 叢集
  cluster_iam_role_name = aws_iam_role.eks_cluster_role.name
}
