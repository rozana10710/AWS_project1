provider "aws" {
  region = "eu-north-1"  # Change this to your preferred AWS region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

//# Call the VPC module
module "vpc" {
  source = "./vpc"
}

# Call the web server module
module "web_server" {
  source = "./web_server"
}

module "rds" {
  source       = "./rds"                     
  db_username  = "admin"         
  db_password  = var.db_password 
  db_name      = "RDS"               
}

module "autoscale" {
  source = "./autoscale"
}
