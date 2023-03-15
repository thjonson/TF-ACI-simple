terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
    }
  }
}

locals {
  instances = csvdecode(file("epgs.csv"))
}

#configure provider with your cisco aci credentials.
provider "aci" {
  username = var.aci_user
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}
/* Replace the resource aci_tenant with data aci_tenant if you want to use an existing tenant
data "aci_tenant" "tenant" {
  name        = var.tenant
}
*/

resource "aci_tenant" "tenant" {
  name = var.tenant
}

resource "aci_vrf" "vrf" {
  tenant_dn = aci_tenant.tenant.id
  #tenant_dn = data.aci_tenant.tenant.id
  name      = var.vrf
}

resource "aci_application_profile" "application_profile" {
  tenant_dn = aci_tenant.tenant.id
  #tenant_dn = data.aci_tenant.tenant.id
  name      = var.app_prof
}

resource "aci_application_epg" "application_epg" {
  for_each               = { for inst in local.instances : inst.key => inst }
  application_profile_dn = aci_application_profile.application_profile.id
  name                   = each.value.epg
  relation_fv_rs_bd      = aci_bridge_domain.bridge_domain[each.key].id
}

resource "aci_bridge_domain" "bridge_domain" {
  for_each           = { for inst in local.instances : inst.key => inst }
  tenant_dn          = aci_tenant.tenant.id
  #tenant_dn         = data.aci_tenant.tenant.id
  name               = each.value.bd
  relation_fv_rs_ctx = aci_vrf.vrf.id
}
resource "aci_subnet" "subnet" {
  for_each  = { for inst in local.instances : inst.key => inst }
  parent_dn = aci_bridge_domain.bridge_domain[each.key].id
  ip        = each.value.bd_subnet
  scope     = ["private"]
}