# AWS 區域設定
variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

# EKS 叢集名稱
variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "asiayo-eks"
}

# VPC CIDR 塊
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# EC2 節點配置
variable "instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

# EKS Kubernetes 版本
variable "eks_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.26"
}

# Node group 配置
variable "node_group_desired_capacity" {
  description = "Desired number of worker nodes in the node group"
  type        = number
  default     = 3
}

variable "node_group_max_capacity" {
  description = "Maximum number of worker nodes in the node group"
  type        = number
  default     = 6
}

variable "node_group_min_capacity" {
  description = "Minimum number of worker nodes in the node group"
  type        = number
  default     = 3
}

# SSH 金鑰名稱
variable "key_name" {
  description = "SSH key name for EC2 instances"
  type        = string
  default     = "my-key-pair"
}
