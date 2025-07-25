resource "aws_security_group" "this" {
  count       = var.create_security_group ? 1 : 0
  name        = "${var.cluster_name}-sg"
  description = "Security group for MSK cluster"
  vpc_id      = var.create_vpc ? aws_vpc.this[0].id : var.vpc_security_group_ids[0]
  tags        = merge(var.tags, { Name = "${var.cluster_name}-sg" })

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}