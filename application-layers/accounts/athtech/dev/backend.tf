terraform {
  backend "s3" {
    bucket         = "demovpc-aws-demo-app-infra"
    dynamodb_table = "demovpc-aws-demo-app-lock"
    key            = "dev/app01/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }
}