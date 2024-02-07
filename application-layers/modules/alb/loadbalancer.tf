resource "aws_lb" "alb_loadbalancer" {
  name               = "${var.application_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.public.ids
  security_groups    = [aws_security_group.alb_security_group.id]

tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.application_name}-lb",
      "Classification" = "private"
    })
  )

}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.application_name}-target-group"
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_loadbalancer.arn
  port              = var.lb_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "dns_name" {
  value = aws_lb.alb_loadbalancer.dns_name
}

output "alb_security_group_id" {
 value = aws_security_group.alb_security_group.id 
}