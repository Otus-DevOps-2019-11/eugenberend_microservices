variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default = "europe-north1"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable zone {
  description = "Zone where VM is to be placed"
  default     = "europe-north1-a"
}
variable instance_count {
  description = "Count of VMs in instance group"
  type        = number
  default     = 1
}
variable app_name {
  description = "Name for application; the name is prefix for all app-related resources too"
}
