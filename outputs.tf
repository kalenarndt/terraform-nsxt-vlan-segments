output "vlan_segment" {
  value = local.vlan_segment_output
  description = "VLAN segment paths and full object output. Ingested in BGP configuration for edges and other objects"
}