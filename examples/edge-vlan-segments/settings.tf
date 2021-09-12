# NSX-T Manager Credentials
provider "nsxt" {
  host                  = var.nsx_manager
  username              = var.nsxt_username
  password              = var.nsxt_password
  allow_unverified_ssl  = true
  retry_on_status_codes = [429]
}
