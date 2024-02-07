resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = concat(
    aws_default_route_table.default_public_route_table.*.id,
    aws_route_table.private.*.id,
    aws_route_table.data.*.id
  )

  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.vpc_name}-s3-vpce",
      "Classification" =  "private"
    })
  )
}