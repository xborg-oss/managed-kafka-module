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
