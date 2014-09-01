class bootparamd::params {
  $config_file      = '/etc/bootparams'
  $service_enable   = true
  $service_ensure   = 'running'
  $service_flags    = '-s'
  $service_name     = 'bootparamd'
}
