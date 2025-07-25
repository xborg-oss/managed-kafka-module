module "msk" {
  source = "../msk-module"

  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes
  broker_instance_type   = var.broker_instance_type

  create_vpc             = var.create_vpc
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  azs                    = var.azs

  create_security_group  = var.create_security_group
  allowed_cidr_blocks    = var.allowed_cidr_blocks

  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids
  
  encryption_in_transit  = var.encryption_in_transit
  client_authentication  = var.client_authentication

  tags = var.tags
}
