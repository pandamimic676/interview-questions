module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "asiayo-vpc"
  cidr = var.vpc_cidr

  enable_dns_support = true
  enable_dns_hostnames = true

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]

  azs = ["us-east-1a", "us-east-1b"]

  tags = {
    "Name" = "asiayo-vpc"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
