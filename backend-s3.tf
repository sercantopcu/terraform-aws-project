terraform {
  backend "s3" {
    bucket = "aws-terraform-project"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}