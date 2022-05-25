variable "domain_name" {
  default = "stag01"
}

variable "domain" {
  default = "stag01"
}

variable "os_image" {
  default = "CirrOS"
}


variable "node_flavor" {
  default = "micro"
}

variable "nw_name" {
  default = "public_net"
}

variable "key_pair" {
  default = "cirros-key-pair"
}

variable "secgroup" {
  default = "cirros-sec-grp"
}
