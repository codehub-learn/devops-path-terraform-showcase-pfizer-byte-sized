## An internet gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.vpc_name}-igw-all",
      "Classification" = "public"
    })
  )
}

## Elastic IPs for use by NAT GWs
resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)
  depends_on = [aws_internet_gateway.igw]
  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "eip-${element(var.availability_zones, count.index)}",
      "Classification" = "public"
    })
  )
}

## Nat GWs for private subnets
resource "aws_nat_gateway" "nat_gw" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.public_subnet.*.id[count.index]
  allocation_id = aws_eip.nat_eip.*.id[count.index]
  depends_on = [aws_internet_gateway.igw]
  tags = merge(
    var.common_tags,
    tomap({
      "Name" = "${var.vpc_name}-nat-az${count.index+1}",
      "Classification" = "private"
    })
  )
}