# Private class, do not use directly.
# Manages the configuration file.
#
class bootparamd::config {
  file { $bootparamd::config_file:
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => epp('bootparamd/bootparams.epp'),
  }
}
