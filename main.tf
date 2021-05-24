resource "nsxt_policy_vlan_segment" "vlan_segment" {
  display_name        = var.segment_name
  description         = var.description
  transport_zone_path = var.transport_zone_path
  vlan_ids            = [var.vlan_id]
  advanced_config {
    uplink_teaming_policy = var.teaming_policy
    connectivity          = "ON"
  }
}

locals {
  vlan_segment_output = nsxt_policy_vlan_segment.vlan_segment
}
