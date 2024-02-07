resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = true
  tags = merge(
    var.common_tags,
    tomap({"Classification" = "private"})
  )
}