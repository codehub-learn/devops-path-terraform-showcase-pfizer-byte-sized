variable "vpc_cidr" {
  description = "IP range of VPC"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "common_tags" {
  type = map(string)
}

variable "vpc_name" {
  type        = string
  description = "VPC name related to the environment"
}

variable "availability_zones" {
  description = "Availability zones that are going to be used for the subnets"
  type        = list(string)
}

variable "subnets_cidrs" {
  description = "Subnet list with IP ranges"
  type        = map(list(string))
}

variable "region" {
  description = "Region to deploy"
  type        = string
}

variable "allowed_hosts" {
  description = "CIDRs of allowed hosts"
  type        = list(string)
}