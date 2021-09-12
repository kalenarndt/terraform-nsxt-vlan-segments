output "vlan_segment_map" {
  value       = nsxt_policy_vlan_segment.vlan_segment
  description = "VLAN segment paths and full object output. Ingested in BGP configuration for edges and other objects"
}

output "vlan_segment_paths" {
  value       = local.segment_to_path
  description = "VLAN Segment names and their associated policy paths"
}
