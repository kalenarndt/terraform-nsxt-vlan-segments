variable "vlan_tz_name" {
  description = "VLAN Transport Zone path that will be used to create the objects. If not set, this will use the default VLAN TZ in NSX-T"
  type        = string
  default     = null
}

variable "default_tz" {
  description = "(Optional) - Toggle to use the NSX-T flagged default VLAN Transport Zone"
  type        = bool
  default     = true
}
variable "segment_name" {
  description = "Name of the VLAN Segment"
  type        = string
}

variable "vlan_ids" {
  description = "(Optional) - VLAN ID for the VLAN Segment"
  type        = list(string)
  default     = null
}

variable "teaming_policy" {
  description = "(Optional) - Segment Teaming Policy to use (defined in the transport zone)"
  type        = string
  default     = null
}
variable "description" {
  description = "(Optional) - Description for the underlying segment"
  type        = string
  default     = null
}

variable "domain_name" {
  description = "(Optional) - DNS domain name to set on the VLAN segment"
  type        = string
  default     = null
}

variable "connectivity" {
  description = "(Optional) - Configuration to manually connect or disconnect"
  type        = string
  default     = "ON"
}
