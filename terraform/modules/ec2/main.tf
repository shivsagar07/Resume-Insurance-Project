#ami → latest Amazon Linux AMI for your region

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
}

module "ec2" {
  source            = "./modules/ec2"
  instance_type     = var.instance_type
  security_group    = module.security.sg_id
  private_subnets   = module.vpc.private_subnets
  target_group_arn = module.alb.target_group_arn
}
