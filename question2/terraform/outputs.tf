output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_kubeconfig" {
  value = module.eks.kubeconfig
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}
