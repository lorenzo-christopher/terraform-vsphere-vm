variable "vsphere_datacenter" {
  description = "vsphere datacenter name where the infrastructure will be deployed"
  type        = string
}

variable "vsphere_cluster" {
  description = "vsphere cluster name where the infrastructure will be deployed"
  type        = string
}

variable "datastore" {
  description = "Datastore used for virtual machines"
  type        = string
}

variable "network" {
  description = "Network used for virtual machines"
  type        = string
}

variable "template" {
  description = "Name of template"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "num_cpus" {
  description = "Number of CPUs"
  type        = number
  default     = 2
}

variable "memory_mb" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "vm_folder" {
  description = "The folder in which the VMs are stored in vcenter"
  type        = string
  default     = ""
}

variable "nested_hv_enabled" {
  description = "Enable nested hardware virtualization"
  type        = bool
  default     = false
}

variable "primary_disk_label" {
  description = "Label for the primary disk"
  type        = string
  default     = "Hard Disk 1"
}

variable "primary_disk_size" {
  description = "Size of primary disk in GB (overrides template size if set)"
  type        = number
  default     = null
}

variable "primary_disk_thin_provisioned" {
  description = "Use thin provisioning for primary disk (overrides template setting if set)"
  type        = bool
  default     = null
}

variable "additional_disks" {
  description = "List of additional disks to attach to the VM"
  type = list(object({
    label            = string
    unit_number      = number
    size             = optional(number)
    thin_provisioned = optional(bool)
    datastore_id     = optional(string)
  }))

  default = []
}

variable "host_name" {
  description = "Hostname of the virtual machine"
  type        = string
}

variable "domain_name" {
  description = "Name of the domain"
  type        = string
}

variable "time_zone" {
  description = "Time zone for the virtual machine"
  type        = string
  default     = "America/Jamaica"
}

variable "ipv4_address" {
  description = "IPv4 Address"
  type        = string
}

variable "ipv4_netmask" {
  description = "IPv4 Netmask"
  type        = string
  default     = "24"
}

variable "ipv4_gateway" {
  description = "IPv4 Gateway"
  type        = string
}

variable "dns_server_list" {
  description = "List of dns servers"
  type        = list(string)
  default     = ["1.1.1.1", "8.8.8.8"]
}

