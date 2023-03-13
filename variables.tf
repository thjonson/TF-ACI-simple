variable "aci_user" {
  description = "The name of the ACI user account"
  default     = "admin"
}
variable "aci_password" {
  description = "The name of the ACI user's password"
}
variable "aci_url" {
  description = "The URL of the APIC"
}
variable "tenant" {
  description = "Name of the tenant"
}
variable "vrf" {
  description = "Name of the VRF"
}
variable "app_prof" {
  description = "Name of the Application Profile"
}