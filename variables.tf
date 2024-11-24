# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t4g.nano"
}

variable "instance_name" {
  description = "EC2 instance name"
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
