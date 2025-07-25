aws_region           = "us-east-1"

cluster_name         = "prod-msk-cluster"
kafka_version        = "3.6.0"
number_of_broker_nodes = 3
broker_instance_type = "kafka.m5.large"

create_vpc           = true
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]

create_security_group = true
allowed_cidr_blocks   = ["10.0.0.0/16"]

subnet_ids             = []
vpc_security_group_ids = []

encryption_in_transit = {
  client_broker = "TLS"
  in_cluster    = true
}

client_authentication = {
  sasl = {
    scram = true
  }
  tls = true
}

tags = {
  Environment = "production"
  Team        = "platform"
}
