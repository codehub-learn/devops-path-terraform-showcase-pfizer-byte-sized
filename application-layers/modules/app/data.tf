data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_network_acls" "vpc_nacls" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "default"
    values = ["true"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["private*"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["public*"]
  }
}


data "aws_subnets" "data" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["data*"]
  }
}

data "aws_security_group" "default_security_group" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "default"
}

data "aws_security_group" "bastion_security_group" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["bastion-sg"]
  }
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["679593333241"] # Debian
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_key_pair" "ssh_key" {
  key_name           = "admin-ssh-key"
  include_public_key = true

  filter {
    name   = "tag:Name"
    values = ["admin-ssh-key"]
  }
}