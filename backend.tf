terraform {
  backend "s3" {
    bucket = "terraform-backend-ron"
    key    = "petclinic/terraform.tfstate"
    region = "ap-south-1"
  }
}