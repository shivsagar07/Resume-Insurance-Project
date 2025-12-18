module "cloudwatch" {
  source   = "./modules/cloudwatch"
  asg_name = module.ec2.asg_name
  email    = "YOUR_EMAIL@gmail.com"
}
#YOU MUST CHANGE

#Replace email with your real email

#Confirm SNS subscription from inbox
