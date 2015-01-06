# Private class, do not include directly.
# This class steers the
# rest of the module
class bootparamd::params {
  $enable_yplookup = false
  $config_file     = '/etc/bootparams'
  $old_sgi_client  = true
  $service_enable  = true
  $service_ensure  = 'running'
  $service_flags   = '-s'
  $service_name    = 'bootparamd'
}
