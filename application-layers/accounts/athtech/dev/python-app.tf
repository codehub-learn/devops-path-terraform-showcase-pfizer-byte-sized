module "python-app" {
  source   = "../../../modules/app"
  vpc_name = var.vpc_name
  #region             = var.region
  application_name = "python"
  ingress_ports    = ["80"]
  common_tags      = var.common_tags
}