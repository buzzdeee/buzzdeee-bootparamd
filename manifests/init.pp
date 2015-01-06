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
  $enable_yplookup = $bootparamd::params::enable_yplookup,
  $config_file     = $bootparamd::params::config_file,
  $old_sgi_client  = $bootparamd::params::old_sgi_client,
  $service_enable  = $bootparamd::params::service_enable,
  $service_ensure  = $bootparamd::params::service_ensure,
  $service_flags   = $bootparamd::params::service_flags,
  $service_name    = $bootparamd::params::service_name,
  $bootparams      = undef,
) inherits bootparamd::params {

  class { 'bootparamd::sysctl':
    old_sgi_client => $old_sgi_client,
  }

  class { 'bootparamd::config':
    enable_yplookup => $enable_yplookup,
    config_file     => $config_file,
    bootparams      => $bootparams,
  }

  class { 'bootparamd::service':
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    service_flags  => $service_flags,
    service_name   => $service_name,
  }

  Class['bootparamd::sysctl'] ->
  Class['bootparamd::config'] ~>
  Class['bootparamd::service']
}
