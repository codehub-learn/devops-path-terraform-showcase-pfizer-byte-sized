resource "aws_security_group" "alb_security_group" {
  name                   = "${var.application_name}-lb-sg"
  vpc_id                 = data.aws_vpc.vpc.id
  description            = "ALB Security Group"
  revoke_rules_on_delete = true

  tags = merge(
    var.common_tags
  )
}

resource "aws_security_group_rule" "alb-sg-ingress" {
  type              = "ingress"
  to_port           = var.lb_port
  from_port         = var.lb_port
  protocol          = "-1"
  description       = "Ingress Port"
  cidr_blocks       = var.allowed_hosts
  security_group_id = aws_security_group.alb_security_group.id
}

resource "aws_security_group_rule" "alb-sg-egress" {
  type              = "egress"
  to_port           = var.lb_port
  from_port         = var.lb_port
  protocol          = "-1"
  description       = "Egress Port"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_security_group.id
}