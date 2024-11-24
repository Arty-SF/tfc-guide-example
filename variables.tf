# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  type        = string
  default     = "t4g.nano"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "Provisioned by Terraform"
}

variable "static_tags" {
  description = "Tags applicable to all resources specific and defined independently to the target environment"
  type        = map(string)
  default     = {}
}


variable "dynamic_tags" {
  description = "Tags applicable to all resources but specific for a target environment only"
  type        = map(string)
  default     = {}
}

# tflint-ignore: terraform_unused_declarations
variable "variables_set_a" {
  description = "A test variable for the variables set - A"
  type        = string
  default     = "A VS var A"
}

variable "TFC_CONFIGURATION_VERSION_GIT_COMMIT_SHA" {
  type = string
}

variable "TFC_CONFIGURATION_VERSION_GIT_TAG" {
  type = string
}

variable "TFC_CONFIGURATION_VERSION_GIT_BRANCH" {
  type = string
}

variable "TFC_RUN_ID" {
  type = string
}
