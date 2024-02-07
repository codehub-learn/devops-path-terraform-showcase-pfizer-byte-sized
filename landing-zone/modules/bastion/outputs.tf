output "bastion_public_dns" {
    value = aws_instance.bastion[*].public_dns
}