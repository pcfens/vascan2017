module "network" {
  source = "modules/aws/network"

  name       = "WM-Main"
  cidr_block = "10.2.0.0/16"
}

module "vcenter" {
  source = "modules/vcenter"

  maint_password = "${var.maint_password}"
}
