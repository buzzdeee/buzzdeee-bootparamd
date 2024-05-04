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
#   Hash: the contents that goes into the config file, default: undef
#
# === Examples
#
#  class { bootparamd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
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
  Hash $bootparams,
) {
  contain bootparamd::sysctl
  contain bootparamd::config
  contain bootparamd::service

  Class['bootparamd::sysctl']
  -> Class['bootparamd::config']
  ~> Class['bootparamd::service']
}
