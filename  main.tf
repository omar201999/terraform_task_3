module "my_vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
}

module "subnets" {
  source = "./modules/subnet"
  vpc_id = module.my_vpc.vpc_id
  igw_id = module.my_vpc.igw_id
}


module "security_groups" {
  source = "./modules/security-group"
  vpc_id = module.my_vpc.vpc_id
  
}

module "instances" {
  #depends_on = [module.alb.pvt_load_balancer_url]
  source = "./modules/ec2-instance"
  vpc_id = module.my_vpc.vpc_id
  public_subnet_1_id = module.subnets.public_subnet_1_id
  public_subnet_2_id = module.subnets.public_subnet_2_id
  private_subnet_1_id = module.subnets.private_subnet_1_id
  private_subnet_2_id = module.subnets.private_subnet_2_id
  lb_ip = module.load_balancers.private_lb_dns
  public_security_group_id = module.security_groups.public_security_group_id
  private_security_group_id = module.security_groups.private_security_group_id
}

module "load_balancers" {
  source = "./modules/load-balancer"
  vpc_id = module.my_vpc.vpc_id
  public_security_group_id = module.security_groups.public_security_group_id
  private_security_group_id = module.security_groups.private_security_group_id
  public_ec2_1= module.instances.public_ec2_1
  public_ec2_2= module.instances.public_ec2_2
  private_ec2_1= module.instances.private_ec2_1
  private_ec2_2= module.instances.private_ec2_2
  public_subnets=[module.subnets.public_subnet_1_id,module.subnets.public_subnet_2_id]
  private_subnets=[module.subnets.private_subnet_1_id,module.subnets.private_subnet_2_id]
}
