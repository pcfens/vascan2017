resource "vsphere_virtual_machine" "vascan-demo" {
  name   = "vascan-demo"
  vcpu   = 1
  memory = 1024

  cluster          = "publicServers"
  folder           = "publicVMs"
  domain           = "it.wm.edu"
  datacenter       = "${var.datacenter}"
  dns_suffixes     = ["example.edu"]
  enable_disk_uuid = true

  dns_servers = ["${var.dns_resolvers}"]

  time_zone = "${var.timezone}"

  network_interface {
    // This name works for create, but forces a new resource on each subsequent
    // run unless changed to
    // label              = "pub-LoadBalanceBackend"
    // https://github.com/terraform-providers/terraform-provider-vsphere/issues/93
    //
    label = "${var.PublicServerNet}"

    ipv4_address       = "192.168.1.10"
    ipv4_prefix_length = "24"
    ipv4_gateway       = "192.168.1.1"
  }

  disk {
    datastore = "datastore_nixEngineering/datastore_nixPublic/datastore1"
    template  = "${var.vm_template}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${var.maint_password} | sudo -S apt update",
      "echo ${var.maint_password} | sudo -S puppet agent -t --server puppet4.it.example.edu || return 0",
    ]

    connection {
      type     = "ssh"
      user     = "maint"
      password = "${var.maint_password}"
    }
  }
}
