output "admin_ssh_key" {
  value     = module.vpc.admin_private_ssh_key
  sensitive = true
}

output "bastion_public_dns" {
  value     = module.bastion.bastion_public_dns
  sensitive = true
}