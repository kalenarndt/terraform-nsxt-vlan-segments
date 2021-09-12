data "nsxt_policy_transport_zone" "vlan_tz" {
  count        = var.default_tz == false ? 1 : 0
  display_name = var.vlan_tz_name
}

// data block that retrieves the path of the vlan tz that is marked as the default transport zone
data "nsxt_policy_transport_zone" "vlan_tz_default" {
  count = var.default_tz ? 1 : 0

  transport_type = "VLAN_BACKED"
  is_default     = true
}

// creates vlan segments based on the data that was passed into the module
resource "nsxt_policy_vlan_segment" "vlan_segment" {
  display_name        = var.segment_name
  description         = var.description
  transport_zone_path = concat(data.nsxt_policy_transport_zone.vlan_tz_default.*.path, [""])[0] != "" ? concat(data.nsxt_policy_transport_zone.vlan_tz_default.*.path, [""])[0] : concat(data.nsxt_policy_transport_zone.vlan_tz.*.path, [""])[0]
  vlan_ids            = [var.vlan_ids]
  domain_name         = var.domain_name
  advanced_config {
    uplink_teaming_policy = var.teaming_policy
    connectivity          = var.connectivity
  }
}

locals {
  segment_to_path = { for segment, path in nsxt_policy_vlan_segment.vlan_segment : (segment.display_name) => segment.path}
}
