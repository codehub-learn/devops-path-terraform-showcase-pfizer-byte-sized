output "public_subnet_ids"{
    value = aws_subnet.public_subnet[*].id
}

output "vpc_id"{
    value = aws_vpc.vpc.id
}

output "admin_private_ssh_key"{
    value = tls_private_key.ssh_key.private_key_openssh
    sensitive = true
}
