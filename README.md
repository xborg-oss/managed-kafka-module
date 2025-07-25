# AWS Managed Kafka (MSK) Terraform Module

This Terraform module provisions an [Amazon Managed Streaming for Apache Kafka (MSK)](https://aws.amazon.com/msk/) cluster and related resources on AWS.

## Features
- Creates an MSK cluster with configurable broker nodes
- Supports encryption, monitoring, and client authentication options
- Optionally provisions MSK configuration, security groups, and IAM roles

## Usage Example

```hcl
module "msk" {
  source = "../msk-module"

  cluster_name           = "example-msk-cluster"
  kafka_version          = "3.4.0"
  number_of_broker_nodes = 3
  broker_instance_type   = "kafka.m5.large"
  subnet_ids             = ["subnet-abc123", "subnet-def456", "subnet-ghi789"]
  vpc_security_group_ids = ["sg-0123456789abcdef0"]

  encryption_in_transit = {
    client_broker = "TLS"
    in_cluster    = true
  }

  client_authentication = {
    sasl = {
      scram = true
    }
    tls = false
  }
}
```

## Module Inputs

| Name                    | Description                                         | Type     | Default | Required |
|-------------------------|-----------------------------------------------------|----------|---------|:--------:|
| `cluster_name`          | Name of the MSK cluster                             | string   | n/a     |   yes    |
| `kafka_version`         | Kafka version to deploy                             | string   | n/a     |   yes    |
| `number_of_broker_nodes`| Number of broker nodes                              | number   | n/a     |   yes    |
| `broker_instance_type`  | Broker instance type                                | string   | n/a     |   yes    |
| `subnet_ids`            | List of subnet IDs for the cluster                  | list     | n/a     |   yes    |
| `vpc_security_group_ids`| List of security group IDs                          | list     | n/a     |   yes    |
| `encryption_in_transit` | Encryption in transit settings                      | map      | see code|   no     |
| `client_authentication` | Client authentication settings                      | map      | see code|   no     |

## Module Outputs

| Name              | Description                        |
|-------------------|------------------------------------|
| `cluster_arn`     | ARN of the MSK cluster             |
| `bootstrap_brokers_tls` | TLS bootstrap brokers string   |
| `zookeeper_connect_string` | Zookeeper connect string    |

## File Structure

- `main.tf`      – Core MSK cluster resource
- `variables.tf` – Input variable definitions
- `outputs.tf`   – Output values
- `example/`     – Example usage of the module

## Requirements
- Terraform >= 1.0
- AWS provider >= 4.0

## License
MIT 