provider "google" {
  credentials = file("secret.json")
  project     = "${var.project_id}"
  region = "${var.region}"
}

resource "google_compute_disk" "volume" {
  name  = "${var.volume_name}"
  type  = "${var.disk_type}"
  zone  = "${var.zone}"
  physical_block_size_bytes = "${var.block_size}"
  size = "${var.disk_size}"
}

resource "google_compute_attached_disk" "attach_volume" {
  disk     = google_compute_disk.volume.self_link 
  instance = google_compute_instance.instance.self_link
}

resource "google_compute_instance" "instance" {
  name         = "${var.instance_name}"
  machine_type = "${var.instance_type}"
  zone = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = true
    automatic_restart = false
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

   metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

output "inventory" {
  value       = "[${var.instance_name}]\ninstance ansible_host=${google_compute_instance.instance.network_interface[0].access_config[0].nat_ip} ansible_user=${SSH_USER} ansible_ssh_private_key_file=${SSH_KEY} ansible_ssh_common_args='-o StrictHostKeyChecking=no' "
  description = "The public IP of the web server"
}

