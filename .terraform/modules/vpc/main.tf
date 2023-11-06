resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = var.tags
}

resource "aws_subnet" "subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.vpc.id
  availability_zone = "${var.region}a"

  tags = var.tags
}

resource "aws_security_group" "security_group" {
  name_prefix = "${var.project_name}_security_group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}