# == Class: bootparamd
#
# Full description of class bootparamd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
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
# Copyright 2014 Your name here, unless otherwise noted.
#
class bootparamd (
  $config_file      = $bootparamd::config_file,
  $service_enable   = $bootparamd::service_enable,
  $service_ensure   = $bootparamd::service_ensure,
  $service_flags    = $bootparamd::service_flags,
  $service_name     = $bootparamd::service_name,
) inherits bootparamd::params {

  concat { $config_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 0,
    mode    => 0644,
    notify  => Service[$service_name],
  }
  Concat[$config_file] -> Service[$service_name]
  class { 'bootparamd::service':
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    service_flags  => $service_flags,
    service_name   => $service_name,
  }
}
