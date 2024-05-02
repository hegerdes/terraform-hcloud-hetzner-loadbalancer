output "targets" {
  value       = local.targets
  description = "Map of the target loadbalancer targets."
}
output "services" {
  value       = local.services
  description = "Map of the target loadbalancer services."
}

output "lb_id" {
  value       = hcloud_load_balancer.this.id
  description = "The ID of the created loadbalancer."
}

output "lb_ipv4" {
  value       = hcloud_load_balancer.this.ipv4
  description = "The public IP (ipv4) of the created loadbalancer."
}

output "lb_ipv6" {
  value       = hcloud_load_balancer.this.ipv6
  description = "The public IP (ipv6) of the created loadbalancer."
}
