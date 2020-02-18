variable "prefix" {
  default = "and-academy-romans"
}


variable "prod" {
  type = bool
  default = false
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.prefix
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  #enable_vpn_gateway = true

  tags = {
    Owner = "romans"
    Project = "and-academy"
  }
}

module "rds" {
  source = "./rds"
  name = var.prefix
  prod = var.prod
  subnets = module.vpc.private_subnets
}

output "db_password" {
  value = module.rds.db_password
}
