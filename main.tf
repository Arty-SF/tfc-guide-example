# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  cloud {
    organization = "artysf-org"
    hostname     = "app.terraform.io"

    workspaces {
      name    = "tfc-guide-example"
      project = "tfc-guide-example"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ec2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.ec2_ami.id
  instance_type = var.instance_type

  root_block_device {
    encrypted = true
  }

  metadata_options {
    # Issue in TF, requires explicit value, @see https://github.com/hashicorp/terraform-provider-aws/issues/16781
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    "ci:git_commit"           = "238ac00fe8126b1cae8917717ff6b24f6ee77aa6"
    "ci:git_file"             = "main.tf"
    "ci:git_last_modified_at" = "2024-11-20 04:15:48"
    "ci:git_org"              = "Arty-SF"
    "ci:git_repo"             = "tfc-guide-example"
    "ci:temporary-flag"       = "true"
    "ci:yor_name"             = "ec2_instance"
    "ci:yor_trace"            = "f315200b-8017-4b63-a537-2556af55246c"
    group-name                = "tfc-guide-workshop"
  }
}
