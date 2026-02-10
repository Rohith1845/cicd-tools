terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "6.0.0"
    }
  }
#  Storing state file in remote location
  backend "s3" {
    bucket = "roboshop-rohith"
    key    = "roboshop-dev-jenkins"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}


provider "aws" {

}