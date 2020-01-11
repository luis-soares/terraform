# https://www.terraform.io/docs/providers/aws/d/subnet.html


resource "aws_subnet" "private" { #aws_subnet.private...
    count               = var.az_count
    cidr_block          = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
    availability_zone   = data.aws_availability_zones.available.names[count.index]
    vpc_id              = aws_vpc.main.id

    tags = { 
      Name = "Private"
    }
}

# https://www.terraform.io/docs/providers/aws/d/availability_zones.html
resource "aws_subnet" "public" { #aws_subnet.private...
    count               = var.az_count
    cidr_block          = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
    availability_zone   = data.aws_availability_zones.available.names[count.index]
    vpc_id              = aws_vpc.main.id
    map_public_ip_on_launch = true

    tags = {
      Name = "Public"
    }


}

#resource "aws_security_group" "subnet" {
#  vpc_id = "${data.aws_subnet.selected.vpc_id}"

#  ingress {
#    cidr_blocks = ["${data.aws_subnet.selected.cidr_block}"]
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#  }
# }
