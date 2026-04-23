variable "yc_service_account_key_file" {
  type = string
}

variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "existing_network_id" {
  type    = string
  default = ""
}

variable "existing_subnet_id" {
  type    = string
  default = ""
}

variable "subnet_cidr" {
  type    = string
  default = "10.11.0.0/24"
}

variable "vm_name" {
  type    = string
  default = "kp2-vm"
}

variable "vm_hostname" {
  type    = string
  default = "kp2-vm"
}

variable "vm_description" {
  type    = string
  default = "TMS KP2 VM"
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "image_id" {
  type    = string
  default = ""
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 1
}

variable "core_fraction" {
  type    = number
  default = 20
}

variable "boot_disk_size" {
  type    = number
  default = 10
}

variable "boot_disk_type" {
  type    = string
  default = "network-hdd"
}

variable "nat" {
  type    = bool
  default = true
}

variable "preemptible" {
  type    = bool
  default = true
}

variable "ssh_public_key" {
  type = string
}

variable "my_ip_cidr" {
  type = string
}
