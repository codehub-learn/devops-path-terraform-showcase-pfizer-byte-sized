resource "aws_ebs_encryption_by_default" "ebs_kms_key" {
  enabled = true
}

resource "aws_s3_account_public_access_block" "s3_block_public_access" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_default_network_acl" "nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id
  subnet_ids = concat(aws_subnet.data_subnet[*].id, aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id)
  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "default-nacl",
      "Classification" = "public"
    })
  )
}

resource "tls_private_key" "ssh_key"{
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "ssh_key" {
    key_name = "admin-ssh-key"
    public_key = tls_private_key.ssh_key.public_key_openssh
    tags = merge(
        var.common_tags,
        tomap({
        "Name" = "admin-ssh-key",
        "Classification" = "public"
        })
  )
}