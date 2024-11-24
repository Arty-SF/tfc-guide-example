# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.76.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "> 0.1.0"
    }
  }

  required_version = ">= 0.14.0"
}
