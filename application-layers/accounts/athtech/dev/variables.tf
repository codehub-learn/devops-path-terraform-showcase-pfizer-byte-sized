variable "vpc_name" {
  description = "VPC Name"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "region" {
  description = "AWS Region"
  type        = string
}