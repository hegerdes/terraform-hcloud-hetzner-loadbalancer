locals {

  location     = "fsn1"
  network_name = "lb-demo"
  # Extend the dynamic LB config here
  loadbalancers = { for index, lb in local.loadbancer_config : lb.name => merge(lb, {}) }
}

################################################################################
# hcloud-loadbalancer Module
################################################################################

module "disabled" {
  source = "../.."

  count      = 0
  location   = local.location
  network_id = hcloud_network.example.id
  name       = "disabeld"
}

module "minimal" {
  source = "../.."

  name       = "minimal"
  network_id = hcloud_network.example.id
  location   = local.location
  services = [{
    name        = "http"
    protocol    = "tcp" # Either tcp, http, https
    name        = "http"
    soure_port  = 80,
    target_port = 32080
  }]
  targets = [
    { name   = "worker"
      type   = "label_selector" # You can also use nodeIDs or IPs
      target = "worker_nodes"   # Label, nodeID or IP
    }
  ]
}

module "advanced" {
  source   = "../.."
  for_each = local.loadbalancers

  network_id = hcloud_network.example.id
  location   = local.location
  services   = try(each.value.services, [])
  targets    = try(each.value.targets, [])
  name       = each.value.name
  public     = try(each.value.public, true)
  private_ip = try(each.value.private_ip, null)
  tags       = { managed_by = "terrafrom" }

  depends_on = [hcloud_network.example]
}

# Multiple node_pools
locals {
  loadbancer_config = [
    {
      name = "ingress",
      type = "lb12"
      services = [
        {
          name        = "http",
          protocol    = "tcp",
          source_port = 80,
          target_port = 32080
        },
        {
          name        = "https",
          protocol    = "tcp",
          source_port = 443,
          target_port = 32443
        }
      ],
      targets = [
        { name = "worker", "type" : "label_selector", "target" : "k8s" }
      ]
    },
    {
      name = "controlplane",
      type = "lb11"
      services = [
        {
          name        = "k8s",
          protocol    = "tcp",
          source_port = 6443,
          target_port = 6443
        }
      ],
      targets = [
        {
          name   = "cp",
          type   = "label_selector",
          target = "k8s_control_plane"
        }
      ]
    }
  ]
}

################################################################################
# helper
################################################################################

# ################# Network #################
resource "hcloud_network" "example" {
  name     = local.network_name
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "example" {
  network_id   = hcloud_network.example.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/24"
}
