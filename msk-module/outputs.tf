output "vpc_id" {
  description = "ID of the VPC created for MSK"
  value       = try(aws_vpc.this[0].id, null)
}

output "subnet_ids" {
  description = "IDs of the subnets created for MSK"
  value       = try(aws_subnet.this[*].id, null)
}

output "security_group_ids" {
  description = "IDs of the security groups used for MSK"
  value       = local.msk_sg_ids
}

output "cluster_arn" {
  description = "ARN of the MSK cluster"
  value       = aws_msk_cluster.this.arn
}

output "bootstrap_brokers_tls" {
  description = "TLS bootstrap brokers string"
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
  sensitive   = true
}

output "zookeeper_connect_string" {
  description = "Zookeeper connect string"
  value       = aws_msk_cluster.this.zookeeper_connect_string
  sensitive   = true
}
