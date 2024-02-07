resource "aws_security_group" "security_group" {
  description = "${var.application_name}-sg"
  vpc_id      = data.aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.application_name}-sg",
      "Classification" = "private"
    })
  )
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = aws_security_group.security_group.id
  source_security_group_id = data.aws_security_group.bastion_security_group.id
  type              = "ingress"
  from_port         = 22
  to_port           = var.ingress_ports[0]
  protocol          = "tcp"
}

resource "aws_security_group_rule" "allow_ingress_from_alb" {
  count = length(var.ingress_ports)
  security_group_id = aws_security_group.security_group.id
  source_security_group_id = module.loadbalancer.alb_security_group_id
  type              = "ingress"
  from_port         = var.ingress_ports[count.index]
  to_port           = var.ingress_ports[count.index]
  protocol          = "tcp"
}


resource "aws_security_group_rule" "allow_egress" {
  security_group_id = aws_security_group.security_group.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}