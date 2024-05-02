# terraform-hcloud-hetzner-loadbalancer terraform module

Terraform module which creates terraform-hcloud-hetzner-loadbalancer resources. The module can be found on the [terraform.io registry](https://registry.terraform.io/modules/hegerdes/hetzner-loadbalancer/hcloud/latest) or on [github](https://github.com/hegerdes/terraform-hcloud-hetzner-loadbalancer).

## Usage

See [`examples`](https://github.com/hegerdes/terraform-hcloud-hetzner-loadbalancer/tree/main/examples) directory for working examples to reference:

```hcl
module "hetzner_loadbalancer" {
  source = "hegerdes/terraform-hcloud-hetzner-loadbalancer/"

  location   = local.location
  network_id = hcloud_network.example.id
  name       = "minimal"
}
```

## Examples

Examples codified under the [`examples`](https://github.com/hegerdes/terraform-hcloud-hetzner-loadbalancer/tree/main/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/hegerdes/terraform-hcloud-hetzner-loadbalancer/tree/main/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | 1.45.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.45.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_load_balancer.this](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer_network.this](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_service.this](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/load_balancer_service) | resource |
| [hcloud_load_balancer_target.this](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/load_balancer_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Loadbalancer location | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Loadbalancer Name | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Loadbalancer network id. | `string` | n/a | yes |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | The private ip of the loadbalancer. Auto assinged if not specified. | `string` | `null` | no |
| <a name="input_public"></a> [public](#input\_public) | Loadbalancer internet facing | `bool` | `true` | no |
| <a name="input_services"></a> [services](#input\_services) | Array of objects describing the loadbalancer target configuration. | <pre>list(object({<br>    name           = string<br>    protocol       = string<br>    proxy_protocol = optional(bool, false)<br>    source_port    = optional(number, 80)<br>    target_port    = optional(number, 80)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Loadbalancer tags/labels | `any` | `{}` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | Array of objects describing the loadbalancer listener (service) configuration. | <pre>list(object({<br>    name   = string<br>    type   = string<br>    target = string<br>  }))</pre> | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | Loadbalancer sku size. | `string` | `"lb11"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | The ID of the created loadbalancer. |
| <a name="output_lb_ipv4"></a> [lb\_ipv4](#output\_lb\_ipv4) | The public IP (ipv4) of the created loadbalancer. |
| <a name="output_lb_ipv6"></a> [lb\_ipv6](#output\_lb\_ipv6) | The public IP (ipv6) of the created loadbalancer. |
| <a name="output_services"></a> [services](#output\_services) | Map of the target loadbalancer services. |
| <a name="output_targets"></a> [targets](#output\_targets) | Map of the target loadbalancer targets. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/hegerdes/terraform-hcloud-hetzner-loadbalancer/main/LICENSE).
