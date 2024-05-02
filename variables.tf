variable "name" {
  type        = string
  description = "Loadbalancer Name"
  validation {
    condition     = length(var.name) >= 3
    error_message = "Name must be at least 3 characters long."
  }
}
variable "public" {
  type        = bool
  default     = true
  description = "Loadbalancer internet facing"
}

variable "type" {
  type        = string
  description = "Loadbalancer sku size."
  default     = "lb11"
  validation {
    condition     = contains(["lb11", "lb21", "lb31"], lower(var.type))
    error_message = "Unsupported load-balancer type."
  }
}

variable "targets" {
  type = list(object({
    name   = string
    type   = string
    target = string
  }))
  default     = []
  description = "Array of objects describing the loadbalancer listener (service) configuration."
  validation {
    condition = alltrue([
      for x in var.targets :
      contains(["server", "label_selector", "ip"], x.type)
    ])
    error_message = "Unsupported target type."
  }
}
variable "services" {
  type = list(object({
    name           = string
    protocol       = string
    proxy_protocol = optional(bool, false)
    source_port    = optional(number, 80)
    target_port    = optional(number, 80)
  }))
  default     = []
  description = "Array of objects describing the loadbalancer target configuration."
  validation {
    condition = alltrue([
      for x in var.services :
      contains(["http", "https", "tcp", "upd"], x.protocol)
    ])
    error_message = "Unsupported service type."
  }
  validation {
    condition = alltrue([
      for x in var.services :
      x.source_port >= 1 && x.source_port <= 65535
    ])
    error_message = "Unsupported source port."
  }
  validation {
    condition = alltrue([
      for x in var.services :
      x.target_port >= 1 && x.target_port <= 65535
    ])
    error_message = "Unsupported target port."
  }
}

variable "location" {
  type        = string
  description = "Loadbalancer location"
  validation {
    condition     = contains(["fsn1", "nbg1", "hel1", "ash", "hil"], lower(var.location))
    error_message = "Unsupported location type."
  }
}

variable "tags" {
  type        = any
  description = "Loadbalancer tags/labels"
  default     = {}
}


variable "private_ip" {
  type        = string
  description = "The private ip of the loadbalancer. Auto assinged if not specified."
  default     = null
}

variable "network_id" {
  type        = string
  description = "Loadbalancer network id."
}
