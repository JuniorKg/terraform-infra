provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    # bucket         = "project-phoenix-state-bucket-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraformlock"
  }
}


