# Example: AWS MSK Module Usage

This example demonstrates how to use the `msk-module` to provision an Amazon MSK cluster, including the required VPC, subnets, and security group.

## Usage

1. Initialize Terraform:
   ```sh
   terraform init
   ```
2. Review the plan:
   ```sh
   terraform plan
   ```
3. Apply the configuration:
   ```sh
   terraform apply
   ```

**Note:** This example will create real AWS resources. Ensure you have the necessary permissions and clean up resources when done:
```sh
terraform destroy
``` 