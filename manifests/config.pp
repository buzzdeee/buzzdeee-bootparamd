# Private class, do not use directly.
# Manages the configuration file.

class bootparamd::config (
  $config_file,
  $enable_yplookup,
  $bootparams,
) {
  file { $config_file:
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('bootparamd/bootparams.erb'),
  }
}
