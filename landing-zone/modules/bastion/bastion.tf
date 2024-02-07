resource "aws_security_group" "lz_bastion_sg" {
    name        = "lz_bastion_sg"
    description = "Security Group For LZ Bastion"
    vpc_id      = var.vpc_id
    tags = merge(
    var.common_tags,
    tomap({
      "Name" = "bastion-sg",
      "Classification" = "public"
    })
  )
}

resource "aws_security_group_rule" "bastion_egress" {
    from_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.lz_bastion_sg.id
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    type = "egress"

}
resource "aws_security_group_rule" "bastion_ingress" {
    for_each = var.bastion_ports
    from_port = each.key
    to_port = each.value
    protocol = "tcp"
    security_group_id = aws_security_group.lz_bastion_sg.id
    cidr_blocks = var.allowed_hosts
    type = "ingress"
}

data "aws_key_pair" "ssh_key" {
  key_name           = "admin-ssh-key"
  include_public_key = true

  filter {
    name   = "tag:Name"
    values = ["admin-ssh-key"]
  }
}

resource "aws_instance" "bastion" {
    ami                         = var.bastion_ami_id
    instance_type               = "t3.micro"
    subnet_id                   = var.bastion_subnet_ids[0]
    associate_public_ip_address = true
    security_groups             = [aws_security_group.lz_bastion_sg.id]
    key_name                    = data.aws_key_pair.ssh_key.key_name
    lifecycle {
        ignore_changes = [security_groups]
    }
    tags = merge(
        var.common_tags,
        tomap({
        "Name" = "bastion",
        "Classification" = "public"
        })
  )
}
