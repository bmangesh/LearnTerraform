output "OPENSTACK-HOST" {
  value       = openstack_compute_instance_v2.openstack-terraform-demo.access_ip_v4
  description = "SRE DevStack Instance IP address"
}

output "PRIVATE-KEY" {
  value       = openstack_compute_keypair_v2.openstack-terraform-demo.private_key
  description = "PRIVATE KEY SSH KEY"
}
