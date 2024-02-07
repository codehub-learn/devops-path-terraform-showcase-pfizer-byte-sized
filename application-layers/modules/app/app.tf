module "instance" {
  source                    = "../ec2"
  count                     = length(data.aws_availability_zones.available.names)
  ami_id                    = data.aws_ami.debian.id
  ssh_key_name              = data.aws_key_pair.ssh_key.key_name
  instance_type             = "t3.micro"
  security_group_ids        = [aws_security_group.security_group.id]
  common_tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.application_name}-${count.index}",
      "Classification" = "private"
    })
  )

  subnet_id                 = data.aws_subnets.private.ids[count.index]
}

resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  count            = length(data.aws_availability_zones.available.names)
  target_group_arn = module.loadbalancer.target_group_arn
  target_id        = module.instance[count.index].instance_id
}
