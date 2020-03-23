variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-c"
}

variable "instance_name" {
  default = "instance"
}

variable "volume_name" {
  default = "volume"
}

variable "project_id" {
  default = "ansible-272015"
}

variable "image" {
  default = "centos-cloud/centos-7"
}

variable "instance_type" {
  default = "f1-micro"
}

variable "disk_type" {
  default = "pd-standard"
}

variable "block_size" {
  default = 4096
}

variable "disk_size" {
  default = 40
}

variable "ssh_user" {
  default = "fabio"
}

variable "ssh_pub_key_file" {
  default = "/root/.ssh/id_rsa.pub"
}
