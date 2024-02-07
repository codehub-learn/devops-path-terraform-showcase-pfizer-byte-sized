region             = "eu-north-1"
vpc_name           = "demovpc"
availability_zones = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
common_tags = {
  Owner       = "Kostas Makedos"
  Application = "CodeHubApps"
  Environment = "Development"
  Tier        = "Application Layers"
}
