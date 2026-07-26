terraform {
  required_providers {
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = ">= 0.21.6"
    }
  }
}

variable "uptime_api_token" {
  type      = string
  sensitive = true
}

provider "betteruptime" {
  api_token = var.uptime_api_token
}
