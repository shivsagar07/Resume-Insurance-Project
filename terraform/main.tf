module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source         = "./modules/ec2"
  subnet_id      = module.vpc.public_subnet_id
  instance_type  = var.instance_type
  security_group = module.security.sg_id
}
