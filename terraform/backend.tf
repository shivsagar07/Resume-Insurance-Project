#create this S3 bucket manually once
terraform {
  backend "s3" {
    bucket = "health-insurance-tf-state-bucket"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}
