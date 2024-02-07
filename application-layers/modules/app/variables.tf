variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}
variable "ingress_ports" {
  description = "List of ports to be allowed"
  type = list(string)
}
#
#variable "availability_zones" {
#  description = "List of availability zones"
#  type        = list(string)
#}
#
#variable "region" {
#  description = "AWS Region"
#  type        = string
#}
#
#
#variable "ingress_ports" {
#  description = "List of ports to open"
#  type        = list(string)
#}
#
#variable "instance_name" {
#  description = "Instance Name"
#}

#

#
#variable "ingress_security_group_id"{
#  description = "Security Group to allow traffic from"
#  type = string
#}