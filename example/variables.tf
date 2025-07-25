variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "kafka_version" {
  description = "Kafka version to deploy"
  type        = string
}

variable "number_of_broker_nodes" {
  description = "Number of broker nodes"
  type        = number
}

variable "broker_instance_type" {
  description = "Instance type for broker nodes"
  type        = string
}

variable "create_vpc" {
  description = "Whether to create a new VPC"
  type        = bool
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "create_security_group" {
  description = "Whether to create a new security group"
  type        = bool
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for SG"
  type        = list(string)
}

variable "encryption_in_transit" {
  description = "Encryption in transit settings"
  type = object({
    client_broker = string
    in_cluster    = bool
  })
}

variable "client_authentication" {
  description = "Client authentication settings"
  type = object({
    sasl = object({
      scram = bool
    })
    tls = bool
  })
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "subnet_ids" {
  description = "Subnet IDs when using existing VPC"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Security Group IDs when using existing VPC"
  type        = list(string)
}
