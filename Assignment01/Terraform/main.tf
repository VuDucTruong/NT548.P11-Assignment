module "vpc" {
  source = "./vpc"
}

module "nat_gateway" {
  source           = "./nat_gateway"
  public_subnet_id = module.vpc.public_subnet.id
  depends_on       = [module.vpc]
}

module "route_table" {
  source            = "./route_table"
  depends_on        = [module.nat_gateway]
  igw_id            = module.vpc.igw.id
  nat_gateway_id    = module.nat_gateway.nat_gateway.id
  private_subnet_id = module.vpc.private_subnet.id
  public_subnet_id  = module.vpc.public_subnet.id
  vpc_id            = module.vpc.aws_vpc.id
}

module "security_group" {
  source     = "./security_group"
  device_ip  = var.device_ip
  vpc_id     = module.vpc.aws_vpc.id
  depends_on = [module.vpc]
}

module "ec2" {
  source            = "./ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  depends_on        = [module.security_group]
  private_ec2_sg_id = module.security_group.private_ec2_sg.id
  public_ec2_sg_id  = module.security_group.public_ec2_sg.id
  private_subnet_id = module.vpc.private_subnet.id
  public_subnet_id  = module.vpc.public_subnet.id
}


