module "loadbalancer"{
    source = "../alb"
    allowed_hosts = ["0.0.0.0/0"]
    application_name = var.application_name
    common_tags = var.common_tags
    vpc_name = var.vpc_name
}