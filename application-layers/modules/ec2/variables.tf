variable "ami_id" {
  description = "AMI ID to be used"
}
#
variable "instance_type" {
  description = "Instance Type"
}

variable "common_tags" {
  type = map(string)
  description = "Common tags"
}

variable "ssh_key_name" {
  description = "SSH Key Name for accessing the instance"
}

variable "associate_public_ip" {
  description = "Instance should have public IP"
  type = bool
  default = false
}

variable "security_group_ids" {
  description = "List of Security Groups IDs for Instance"
  type        = list(any)
}

variable "root_volume_size" {
  description = "Size of Root Disk Volume"
  default     = 10
}

variable "subnet_id" {
  description = "Subnet ID to launch Instance"
}
