# Terraform NSX-T VLAN Segments

This Terraform module creates multiple NSX-T VLAN backed segments.

## Usage/Examples

The example below imports a yaml file and loops through the configuration as it creates VLAN backed segments in the environment. Tier-0 routers are not required and default to null if a target tier-0 router isn't specified for the module call. 


```hcl
# Input Variables
locals {
  nsxt_config                        = yamldecode(file("${path.module}/nsxt-config.yaml"))
  edge_vlan_segments                 = local.nsxt_config.edge_vlan_segments
  vlan_segments                      = local.nsxt_config.vlan_segments
  vlan_target_transport_zone_name    = "nsx-vlan-transportzone"  
}

# data block that reads from the datasource (transport zone) and stores it as a local object to be referenced in the resource blocks below.
data "nsxt_policy_transport_zone" "vlan_tz" {
  display_name = local.vlan_target_transport_zone_name
}

# local object for vlan transport zone and vlan transport zone path. 
locals {
  vlan_tz_obj     = data.nsxt_policy_transport_zone.vlan_tz
  vlan_tz_path    = data.nsxt_policy_transport_zone.vlan_tz.path
}


# module that creates multiple VLAN backed edge peering segments
module "edge_vlan_segments" {
  for_each            = local.edge_vlan_segments
  source              = "github.com/kalenarndt/terraform-nsxt-vlan-segments"
  segment_name        = each.value.segment_name
  vlan_id             = each.value.vlan_id
  teaming_policy      = each.value.teaming_policy
  description         = each.value.description
  transport_zone_path = local.vlan_tz_path
}

# module that creates multiple VLAN backed segments
module "internal_vlan_segments" {
  for_each            = local.vlan_segments
  source              = "github.com/kalenarndt/terraform-nsxt-vlan-segments"
  segment_name        = each.value.segment_name
  vlan_id             = each.value.vlan_id
  description         = each.value.description
  transport_zone_path = local.vlan_tz_path
}

```

Ensure that you modify the nsxt-config.yaml file to match the objects that you would like to deploy as this is what the module uses to deploy and configure the tier1 gateways.

Place the nsxt-config.yaml file where your main.tf file is in your deployment or modify the usage example for the path to your yaml I

```yaml
# edge vlan segments section. If you modify the segment_name here ensure you modify the segment_name under the router_ports section or router port creation will fail.
# These segments are used for BGP peering from the Edge Nodes
edge_vlan_segments:
  edge_path_a:
    segment_name: seg-edge-fa-vl100
    vlan_id: "100"
    teaming_policy: tor-1
    description: Segment for BGP peering on Fabric-A - Created by Terraform
  edge_path_b:
    segment_name: seg-edge-fb-vl101
    vlan_id: "101"
    teaming_policy: tor-2
    description: Segment for BGP peering on Fabric-B - Created by Terraform

# vlan segments section. General VLAN segment creation for vmkernels and vms that do not require overlay networking.
vlan_segments:
  management:
    segment_name: seg-mgmt-vl17
    vlan_id: "17"
    description: Segment for Management workloads  - Created by Terraform
  nfs:
    segment_name: seg-nfs-vl1
    vlan_id: "0"
    description: Segment for NFS traffic - Created by Terraform
  vmotion:
    segment_name: seg-vmotion-vl10
    vlan_id: "10"
    description: Segment for vMotion traffic - Created by Terraform
  workload:
    segment_name: seg-workload-vl18
    vlan_id: "10"
    description: Segment for Workload traffic - Created by Terraform    
```

  
## License

[MIT](https://choosealicense.com/licenses/mit/)

  






<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |
| <a name="requirement_nsxt"></a> [nsxt](#requirement\_nsxt) |  >=3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_nsxt"></a> [nsxt](#provider\_nsxt) |  >=3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [nsxt_policy_vlan_segment.vlan_segment](https://registry.terraform.io/providers/vmware/nsxt/latest/docs/resources/policy_vlan_segment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the underlying segment | `string` | n/a | yes |
| <a name="input_segment_name"></a> [segment\_name](#input\_segment\_name) | Name of the VLAN Segment | `any` | n/a | yes |
| <a name="input_teaming_policy"></a> [teaming\_policy](#input\_teaming\_policy) | Segment Teaming Policy to use (defined in the transport zone) | `any` | `null` | no |
| <a name="input_transport_zone_path"></a> [transport\_zone\_path](#input\_transport\_zone\_path) | VLAN Transport Zone path that will be used to create the objects | `string` | n/a | yes |
| <a name="input_vlan_id"></a> [vlan\_id](#input\_vlan\_id) | VLAN ID for the VLAN Segment | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vlan_segment"></a> [vlan\_segment](#output\_vlan\_segment) | n/a |
<!-- END_TF_DOCS -->