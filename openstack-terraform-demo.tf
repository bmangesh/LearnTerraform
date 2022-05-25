terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}


### OPENSTACK CREDENTIALS ###
provider "openstack" {
#  project_domain_name = var.domain_name
#  user_domain_name = var.domain
}

#Create Security Group
resource "openstack_compute_secgroup_v2" "secgroup_terraform" {
  name        = var.secgroup
  description = "security group created by Terraform"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

}

# Keypair
resource "openstack_compute_keypair_v2" "openstack-terraform-demo" {
  name = var.key_pair
}


resource "openstack_blockstorage_volume_v2" "terraform_volume_test" {
  name = "terraform_volume_test"
  size = 1
}

### OPENSTACK COMPUTE RESOURCE###

resource "openstack_compute_instance_v2" "openstack-terraform-demo" {
  name         = "openstack-terraform-demo"
  image_name = var.os_image
  flavor_name = var.node_flavor
  security_groups = ["${openstack_compute_secgroup_v2.secgroup_terraform.name}"]
  key_pair = var.key_pair

  lifecycle {
    create_before_destroy = true
  }

  network {
    name = var.nw_name
  }

}

resource "openstack_compute_volume_attach_v2" "va_1" {
  instance_id = "${openstack_compute_instance_v2.openstack-terraform-demo.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.terraform_volume_test.id}"
}
