# terraform-vsphere-vm

Basic terraform vSphere module for provisioning Virtual Machines.

### Basic Example

```hcl
module "vm" {
  source = "github.com/lorenzo-christopher/terraform-vsphere-vm"

  # vSphere Infrastructure
  vsphere_datacenter = "DC1"
  vsphere_cluster    = "Cluster1"
  datastore          = "datastore1"
  network            = "VM Network"
  template           = "ubuntu-24.04-template"

  # VM Configuration
  vm_name   = "web-server-01"
  vm_folder = "Production/WebServers"
  num_cpus  = 4
  memory_mb = 8192

  # Guest Customization
  host_name   = "web-server-01"
  domain_name = "example.com"
  time_zone   = "America/Jamaica"

  # Network Configuration
  ipv4_address    = "192.168.1.100"
  ipv4_netmask    = 24
  ipv4_gateway    = "192.168.1.1"
  dns_server_list = ["8.8.8.8", "8.8.4.4"]
}
```

### Example with Additional Disks

```hcl
module "database_vm" {
  source = "github.com/lorenzo-christopher/terraform-vsphere-vm"

  # vSphere Infrastructure
  vsphere_datacenter = "DC1"
  vsphere_cluster    = "Cluster1"
  datastore          = "datastore1"
  network            = "VM Network"
  template           = "rhel-10-template"

  # VM Configuration
  vm_name   = "db-server-01"
  vm_folder = "Production/Databases"
  num_cpus  = 8
  memory_mb = 16384

  # Primary Disk
  primary_disk_label           = "os-disk"
  primary_disk_size            = 128
  primary_disk_thin_provisioned = true

  # Additional Disks
  additional_disks = [
    {
      label            = "data-disk-1"
      unit_number      = 1
      size             = 512
      thin_provisioned = true
    },
    {
      label            = "logs-disk"
      unit_number      = 2
      size             = 256
      thin_provisioned = true
    }
  ]

  # Guest Customization
  host_name   = "db-server-01"
  domain_name = "example.com"
  time_zone   = "America/Jamaica"

  # Network Configuration
  ipv4_address    = "192.168.1.101"
  ipv4_netmask    = 24
  ipv4_gateway    = "192.168.1.1"
  dns_server_list = ["192.168.1.10", "192.168.1.11"]
}
```
