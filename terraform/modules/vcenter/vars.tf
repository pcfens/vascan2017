variable "datacenter" {
  default = "wm"
}

variable "vm_template" {
  default = "nixEngineering/templates/template"
}

variable "IntraNet" {
  default = "intra-intranet"
}

variable "LoadBalancedNet" {
  default = "pub-LoadBalanceBackend"
}

variable "PublicServerNet" {
  default = "PublicServernet"
}

variable "timezone" {
  default = "America/New_York"
}

variable "dns_resolvers" {
  default = [
    "128.239.20.9",
    "128.239.29.9",
  ]
}

variable "maint_password" {}
