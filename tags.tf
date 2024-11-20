locals {
  tags = merge({
    temporary-flag = "true"
  }, var.common_tags)
}