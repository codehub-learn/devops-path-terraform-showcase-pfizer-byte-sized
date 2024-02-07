module "vpc" {
  source   = "../../../../modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  region   = var.region
  common_tags = merge(
    var.common_tags,
    tomap({
      "Name" = var.vpc_name
    })
  )
  availability_zones = var.availability_zones
  subnets_cidrs      = var.subnets_cidrs
}

module "bastion" {
  source         = "../../../../modules/bastion"
  vpc_id         = module.vpc.vpc_id
  allowed_hosts  = ["178.147.110.52/32"]
  bastion_ami_id = "ami-04c5835f77943eb78"
  bastion_ports = {
    "22" : "22"
  }
  bastion_subnet_ids = module.vpc.public_subnet_ids
  common_tags        = var.common_tags
  depends_on         = [module.vpc]
}


module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.vpc_name}-aws-demo-app-infra"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
  tags = var.common_tags
}

resource "aws_dynamodb_table" "application_state_lock_dynamodb_table" {
  name           = "${var.vpc_name}-aws-demo-app-lock"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.common_tags
}