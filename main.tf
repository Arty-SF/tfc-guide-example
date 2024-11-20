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
    Name = var.instance_name
  }
}
