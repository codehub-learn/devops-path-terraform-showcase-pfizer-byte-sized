region             = "eu-north-1"
vpc_name           = "demovpc"
vpc_cidr           = "10.20.0.0/20"
availability_zones = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
subnets_cidrs = {
  "public"  = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"],
  "private" = ["10.20.5.0/24", "10.20.6.0/24", "10.20.7.0/24"],
  "data"    = ["10.20.10.0/24", "10.20.11.0/24", "10.20.12.0/24"]
}
common_tags = {
  Owner       = "Kostas Makedos"
  Company     = "Athtech"
  Application = "TF Demo"
  Environment = "Development"
  Tier        = "Landing Zone"
}
allowed_hosts = ["178.148.0.0/16"]
