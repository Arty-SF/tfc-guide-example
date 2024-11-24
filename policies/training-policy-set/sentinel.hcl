# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

policy "allowed-terraform-version" {
  # options:
  # - hard-mandatory
  # - soft-mandatory : interrupts but admin can override policy
  # - advisory : never interrupt the run
  enforcement_level = "soft-mandatory"
}
