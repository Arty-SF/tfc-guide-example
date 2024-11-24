locals {
  tags = merge(var.static_tags, var.dynamic_tags)
}
