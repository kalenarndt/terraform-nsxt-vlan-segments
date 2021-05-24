variable "transport_zone_path" {
  description = "VLAN Transport Zone path that will be used to create the objects"
  type        = string
}
variable "segment_name" {
  description = "Name of the VLAN Segment"
}
variable "vlan_id" {
  description = "VLAN ID for the VLAN Segment"
  type        = number
}
variable "teaming_policy" {
  description = "Segment Teaming Policy to use (defined in the transport zone)"
  default     = null
}
variable "description" {
  description = "Description for the underlying segment"
  type        = string
}