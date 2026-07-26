resource "betteruptime_status_page" "this" {
  company_name  = "TangledWires"
  company_url   = "https://tangledwires.co.uk/"
  contact_url   = "mailto:support@tangledwires.co.uk"
  custom_domain = "status.tangledwires.co.uk"
  subdomain     = "tangledwires"
  design        = "v2"
  theme         = "dark"
  timezone      = "Edinburgh"
  dark_logo_url = "https://tangledwires.co.uk/images/logo_dark2.png"
}

locals {
  sections = {
    services = {
      name     = "Services"
      position = 0
    }
    infrastructure = {
      name     = "Infrastructure"
      position = 1
    }
  }

  monitors = {
    # Services
    main_site = {
      url          = "https://tangledwires.co.uk/"
      public_name  = "tangledwires.co.uk"
      section      = "services"
      monitor_type = "status"
      position     = 0
    }
    stationary = {
      url          = "https://stationary.tangledwires.co.uk/"
      public_name  = "stationary.tangledwires.co.uk"
      section      = "services"
      monitor_type = "status"
      position     = 1
    }
    auth = {
      url          = "https://auth.tangledwires.co.uk/"
      public_name  = "auth.tangledwires.co.uk"
      section      = "services"
      monitor_type = "status"
      position     = 2
    }

    # Infrastructure
    control_plane = {
      url          = "control-plane.prod.infra.tangledwires.co.uk"
      public_name  = "control-plane.prod.infra.tangledwires.co.uk"
      section      = "infrastructure"
      monitor_type = "ping"
      position     = 0
    }
    node_0 = {
      url          = "node-0.prod.infra.tangledwires.co.uk"
      public_name  = "node-0.prod.infra.tangledwires.co.uk"
      section      = "infrastructure"
      monitor_type = "ping"
      position     = 1
    }
    node_1 = {
      url          = "node-1.prod.infra.tangledwires.co.uk"
      public_name  = "node-1.prod.infra.tangledwires.co.uk"
      section      = "infrastructure"
      monitor_type = "ping"
      position     = 2
    }
    node_2 = {
      url          = "node-2.prod.infra.tangledwires.co.uk"
      public_name  = "node-2.prod.infra.tangledwires.co.uk"
      section      = "infrastructure"
      monitor_type = "ping"
      position     = 3
    }
  }
}

resource "betteruptime_status_page_section" "this" {
  for_each = local.sections

  status_page_id = betteruptime_status_page.this.id
  name           = each.value.name
  position       = each.value.position
}

resource "betteruptime_monitor" "this" {
  for_each = local.monitors

  url          = each.value.url
  monitor_type = each.value.monitor_type
}

resource "betteruptime_status_page_resource" "this" {
  for_each = local.monitors

  status_page_id         = betteruptime_status_page.this.id
  resource_id            = betteruptime_monitor.this[each.key].id
  status_page_section_id = betteruptime_status_page_section.this[each.value.section].id
  public_name            = each.value.public_name
  position               = each.value.position
  resource_type          = "Monitor"
}