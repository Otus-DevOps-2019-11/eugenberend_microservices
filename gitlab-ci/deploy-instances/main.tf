terraform {
  # Версия terraform
  required_version = ">=0.12.8"
}
provider "google" {
  # Версия провайдера
  version = "2.15"
  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  count        = var.instance_count
  name         = "${var.app_name}${count.index}"
  machine_type = "n1-standard-1"
  zone         = var.zone
  tags         = [var.app_name]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  metadata = {
    # путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
}
resource "google_compute_firewall" "firewall_puma" {
  name = "allow-${var.app_name}"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = [var.app_name]
}
