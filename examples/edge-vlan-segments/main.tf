# Input Variables
locals {
  nsxt_config        = yamldecode(file("${path.module}/nsxt-vlans.yaml"))
  edge_vlan_segments = local.nsxt_config.edge_vlan_segments
  vlan_segments      = local.nsxt_config.vlan_segments
}

# module that creates multiple VLAN backed edge peering segments
module "edge_vlan_segments" {
  source         = "./modules/terraform-nsxt-vlan-segments"
  for_each       = local.edge_vlan_segments
  segment_name   = each.value.segment_name
  vlan_ids       = each.value.vlan_id
  teaming_policy = each.value.teaming_policy
  description    = each.value.description
}
