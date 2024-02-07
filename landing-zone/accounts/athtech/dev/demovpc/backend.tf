terraform {
  backend "s3" {
    bucket         = "athtech-demo-landing-zone"
    dynamodb_table = "athtech-demo-lz-lock"
    key            = "dev/myvpc/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}