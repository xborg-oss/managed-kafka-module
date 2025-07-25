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
  description = "Broker instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cluster"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs"
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

variable "create_vpc" {
  description = "Whether to create a new VPC for MSK"
  type        = bool
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC"
  type        = string
  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]+$", var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.public_subnet_cidrs : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]+$", cidr))])
    error_message = "All public_subnet_cidrs must be valid CIDR blocks."
  }
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
  description = "List of CIDR blocks allowed to access MSK"
  type        = list(string)
  validation {
    condition     = length(var.allowed_cidr_blocks) > 0
    error_message = "You must specify at least one allowed CIDR block."
  }
}
