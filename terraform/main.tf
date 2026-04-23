locals {
  use_existing_network = var.existing_network_id != ""
  use_existing_subnet  = var.existing_subnet_id != ""

  network_id = local.use_existing_network ? var.existing_network_id : yandex_vpc_network.kp2-network[0].id
  subnet_id  = local.use_existing_subnet ? var.existing_subnet_id : yandex_vpc_subnet.kp2-subnet[0].id
}

resource "yandex_vpc_network" "kp2-network" {
  count = local.use_existing_network ? 0 : 1
  name  = "kp2-network"
}

resource "yandex_vpc_subnet" "kp2-subnet" {
  count          = local.use_existing_subnet ? 0 : 1
  name           = "kp2-subnet-a"
  zone           = var.yc_zone
  network_id     = local.network_id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "kp2" {
  name       = "kp2-sg"
  network_id = local.network_id

  ingress {
    description    = "SSH from my IP"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description    = "App from my IP"
    protocol       = "TCP"
    port           = 5000
    v4_cidr_blocks = [var.my_ip_cidr]
  }

  ingress {
    description    = "Jenkins from my IP"
    protocol       = "TCP"
    port           = 8080
    v4_cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description    = "Allow all outgoing"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

module "kp2-vm" {
  source = "./modules/vm"

  vm_name        = var.vm_name
  vm_hostname    = var.vm_hostname
  vm_description = var.vm_description

  zone      = var.yc_zone
  subnet_id = local.subnet_id

  image_family = var.image_family
  image_id     = var.image_id
  platform_id  = var.platform_id

  cores         = var.cores
  memory        = var.memory
  core_fraction = var.core_fraction

  boot_disk_size = var.boot_disk_size
  boot_disk_type = var.boot_disk_type

  nat                = var.nat
  preemptible        = var.preemptible
  ssh_public_key     = var.ssh_public_key
  security_group_ids = [yandex_vpc_security_group.kp2.id]

  depends_on = [
    yandex_vpc_network.kp2-network,
    yandex_vpc_subnet.kp2-subnet
  ]
}
