resource "aws_vpc" "this" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(var.tags, { Name = "${var.cluster_name}-vpc" })
}

resource "aws_subnet" "this" {
  count                   = var.create_vpc ? length(var.public_subnet_cidrs) : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.cluster_name}-subnet-${count.index}" })
}

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

locals {
  msk_subnet_ids = var.create_vpc ? aws_subnet.this[*].id : var.subnet_ids
  msk_sg_ids     = var.create_security_group ? [aws_security_group.this[0].id] : var.vpc_security_group_ids
}

resource "aws_msk_cluster" "this" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = local.msk_subnet_ids
    security_groups = local.msk_sg_ids
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.encryption_in_transit.client_broker
      in_cluster    = var.encryption_in_transit.in_cluster
    }
  }

  client_authentication {
    sasl {
      scram = var.client_authentication.sasl.scram
    }
    tls {}
  }

  tags = merge(var.tags, { Name = var.cluster_name })
}
