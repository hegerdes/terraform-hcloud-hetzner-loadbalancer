# LoadBalancer
resource "hcloud_load_balancer" "this" {
  name               = var.name
  load_balancer_type = var.type
  location           = var.location
  delete_protection  = false
  labels             = var.tags
  lifecycle {
    ignore_changes = [labels["hcloud-ccm/service-uid"]]
  }
}

resource "hcloud_load_balancer_network" "this" {
  load_balancer_id        = hcloud_load_balancer.this.id
  network_id              = var.network_id
  ip                      = var.private_ip
  enable_public_interface = var.public
}

resource "hcloud_load_balancer_target" "this" {
  for_each         = local.targets
  load_balancer_id = hcloud_load_balancer.this.id

  type           = each.value.type
  label_selector = each.value.type == "label_selector" ? each.value.target : null
  ip             = each.value.type == "ip" ? each.value.target : null
  server_id      = each.value.type == "server" ? tonumber(each.value.target) : null
  use_private_ip = each.value.type != "ip" ? true : null

  depends_on = [hcloud_load_balancer_network.this]
}

locals {
  targets  = { for index, target in var.targets : target.name => target }
  services = { for index, target in var.services : target.name => target }
}

resource "hcloud_load_balancer_service" "this" {
  for_each         = local.services
  load_balancer_id = hcloud_load_balancer.this.id
  protocol         = each.value.protocol
  listen_port      = each.value.protocol == "tcp" ? each.value.source_port : null
  destination_port = each.value.protocol == "tcp" ? each.value.target_port : null
  proxyprotocol    = each.value.proxy_protocol

  depends_on = [
    hcloud_load_balancer_network.this
  ]
}
