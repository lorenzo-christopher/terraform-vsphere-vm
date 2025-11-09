terraform {
  required_version = ">= 0.13.4"
  required_providers {
    vsphere = {
      source  = "vmware/vsphere"
      version = "2.15.0"
    }
  }
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name              = var.vm_name
  resource_pool_id  = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id      = data.vsphere_datastore.datastore.id
  num_cpus          = var.num_cpus
  memory            = var.memory_mb
  guest_id          = data.vsphere_virtual_machine.template.guest_id
  scsi_type         = data.vsphere_virtual_machine.template.scsi_type
  folder            = var.vm_folder
  firmware          = data.vsphere_virtual_machine.template.firmware
  nested_hv_enabled = var.nested_hv_enabled

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = var.primary_disk_label
    size             = var.primary_disk_size != null ? var.primary_disk_size : data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = var.primary_disk_thin_provisioned != null ? var.primary_disk_thin_provisioned : data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  dynamic "disk" {
    for_each = var.additional_disks
    content {
      label            = disk.value.label
      unit_number      = disk.value.unit_number
      size             = lookup(disk.value, "size", 32)
      thin_provisioned = lookup(disk.value, "thin_provisioned", true)
      datastore_id     = lookup(disk.value, "datastore_id", null)
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      timeout = "10"

      linux_options {
        host_name = var.host_name
        domain    = var.domain_name
        time_zone = var.time_zone
      }

      network_interface {
        ipv4_address = var.ipv4_address
        ipv4_netmask = var.ipv4_netmask
      }

      ipv4_gateway    = var.ipv4_gateway
      dns_server_list = var.dns_server_list
    }
  }
}

