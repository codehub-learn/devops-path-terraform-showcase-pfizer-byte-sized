variable "vpc_id" {
    type = string
    description = "VPC ID that bastion belongs too"
}

variable "bastion_ports" {
    type = map(string)
    description = "A map of ports to oper for Bastion"
}

variable "allowed_hosts" {
    type = list(string)
    description = "A list of CIDRs to allow accessing Bastion"
}

variable "bastion_ami_id" {
    type = string
    description = "AMI ID for bastion"
}

variable "bastion_subnet_ids" {
    type = list(string)
    description = "List of subnets that bastion can be deployed"
}

variable "common_tags" {
  type = map(string)
  description = "Common tags"
}
