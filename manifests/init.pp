# == Class: bootparamd
#
# Full description of class bootparamd here.
#
# === Parameters
#
# Document parameters here.
#
# [*enable_yplookup*]
#   Boolean: whether to enable yplookup, default: false
#
# [*config_file*]
#   String: the bootparams config file, default: /etc/bootparams
#
# [*old_sgi_client*]
#   Boolean: enables sysctl to lock down high ports for bootparamd
#   to listen on. default: false
#
# [*service_enable*]
#   Boolean: whether to enable the service or not, default: true
#
# [*service_ensure*]
#   Enum[running, stopped]: the desired state of bootparamd, default: running
#
# [*service_flags*]
#   String: the service flags, default: '-s'
#
# [*service_name*]
#   String: the name of the service, default: bootparamd
#
# [*bootparams*]
#   Optional Hash: the contents that goes into the config file, default: undef
#
# === Examples
#
# In the very simplest case, you just include the following:
#
# include bootparamd
#
# Configuration example for Hiera:
#
# bootparamd::bootparams:
#   node1:
#     nfsrootserver: "192.168.1.23"
#     nfsrootpath: '/export/node1'
#     nfsswapserver: "192.168.1.23"
#     nfsswappath: '/export/swap1'
#     nfsdumpserver: "192.168.1.23"
#     nfsdumppath: '/export/dump1'
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Sebastian Reitenbach, unless otherwise noted.
#
class bootparamd (
  Boolean $enable_yplookup,
  String $config_file,
  Boolean $old_sgi_client,
  Boolean $service_enable,
  Enum[running, stopped, 'running', 'stopped'] $service_ensure,
  String $service_flags,
  String $service_name,
  Optional[Hash] $bootparams,
) {
  contain bootparamd::sysctl
  contain bootparamd::config
  contain bootparamd::service

  Class['bootparamd::sysctl']
  -> Class['bootparamd::config']
  ~> Class['bootparamd::service']
}
