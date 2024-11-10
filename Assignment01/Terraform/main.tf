module "vpc" {
  source = "./modules/vpc"
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.vpc.public_subnet_id
  depends_on       = [module.vpc]
}

module "route_table" {
  source            = "./modules/route_table"
  depends_on        = [module.nat_gateway]
  igw_id            = module.vpc.igw_id
  nat_gateway_id    = module.nat_gateway.nat_gateway_id
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id  = module.vpc.public_subnet_id
  vpc_id            = module.vpc.aws_vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  depends_on        = [module.vpc]
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id  = module.vpc.public_subnet_id
  device_ip         = var.device_ip
  vpc_id            = module.vpc.aws_vpc_id
  iam_role = var.iam_role
}





