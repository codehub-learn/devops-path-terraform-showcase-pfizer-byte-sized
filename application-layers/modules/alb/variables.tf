variable "vpc_name" {
  description = "VPC Name to deploy app"
}

variable "application_name" {
  description = "Name of the application"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply"
  type        = map(string)
}

variable "lb_port" {
  description = "Load Balancer port"
  type        = string
  default     = "80"
}

variable "target_group_port" {
  description = "Application Load Balancer Target Group Port"
  type        = number
  default     = 80
}

variable "allowed_hosts" {
  description = "List of CIDRs to allow access"
}

#variable "security-groups-ids" {
#  description = "List of Security Groups IDs for ALB"
#  type        = list(any)
#}