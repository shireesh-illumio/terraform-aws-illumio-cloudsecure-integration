# Terraform Illumio CloudSecure Integration

The Illumio CloudSecure Modules enables [Terraform](https://terraform.io/) to manage [Illumio CloudSecure](https://www.illumio.com/products/illumio-cloudsecure) resources with cloud resources to provide security visibility and control across your cloud environments. 

## Minimum Requirements

- Terraform 1.7 or newer. We recommend running the [latest version](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform) for optimal compatibility with the Illumio CloudSecure Modules.

## Documentation

How to use the Illumio CloudSecure Modules:

### AWS ACCOUNT 
```hcl
module "aws_account" {
  source  = "shireesh-illumio/illumio-cloudsecure-integration/aws//modules/aws-account"
  version = "1.0.0"
  iam_role_name = "IllumioCloudIntegrationRole"
  mode = "ReadWrite"
  account_name = "My AWS Account"
}
```


### AWS Organization 
```hcl

provider "aws" {
  profile = "default"
}

provider "aws" {
  alias  = "123456789011"
  profile = "account1"
}

provider "aws" {
  alias  = "123456789012"
  profile = "account2"
}

data "aws_organizations_organization" "current" {}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}


module "aws_org1" {
  for_each = toset(aws_organizations_organization.current.accounts[*].id)
  source  = "shireesh-illumio/illumio-cloudsecure-integration/aws//modules/aws-account"
  iam_role_name = "IllumioCloudIntegrationRole"
  mode = "ReadWrite"
  account_type = "Organization"
  account_name = "My AWS Organization"
  management_account_id = data.aws_caller_identity.current.account_id
  organization_id = data.aws_organizations_organization.current.id
  providers = {
    aws = aws[each.value]
  }
}
```


## Support

The Terraform Illumio CloudSecure Modules are released and distributed as open source software subject to the included [LICENSE](../../LICENSE). Illumio has no obligation or responsibility related to the package with respect to support, maintenance, availability, security or otherwise. Please read the entire [LICENSE](../../LICENSE) for additional information regarding the permissions and limitations.

For bugs and feature requests, please open a Github Issue and label it appropriately.
