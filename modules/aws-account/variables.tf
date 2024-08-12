# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------


variable "account_name" {
  description = "Name of the AWS account."
  type        = string
  validation {
    condition     = length(var.account_name) > 1
    error_message = "The account name cannot be empty."
  }
}

variable "account_type" {
  description = "AWS account type, must be \"Account\" or \"Organization\"."
  type = string
  default = "Account"

  validation {
    condition     = contains(["Account", "Organization"], var.account_type)
    error_message = "The account type must be either 'Account' or 'Organization'."
  }
}

variable "management_account_id" {
    description = "AWS management account ID."
    type        = string
    default     = ""

    validation {
        condition     = length(var.management_account_id) > 1 || var.account_type == "Account"
        error_message = "The management account ID cannot be empty."
    }
}


variable "organization_id" {
    description = "AWS organization ID."
    type        = string
    default     = ""

    validation {
        condition     = length(var.organization_id) > 1 || var.account_type == "Account"
        error_message = "The organization ID cannot be empty."
    }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have default values and can be modified based on the requirement.
# ---------------------------------------------------------------------------------------------------------------------


variable "iam_role_name" {
  description = "Customize the name of IAM role for Illumio AWS integration"
  type        = string
  default     = "IllumioCloudIntegrationRole"
  validation {
    condition     = length(var.iam_role_name) > 1
    error_message = "The IAM role name cannot be empty."
  }
}

variable "mode" {
  description = "integration mode Read/ReadWrite."
  type        = string
  default     = "ReadWrite"
  validation {
    condition     = contains(["Read", "ReadWrite"], var.mode)
    error_message = "Must be Read or ReadWrite"
  }
}


