# Private class, do not use directly.
# Manages the configuration file.
# [*enable_yplookup*]
#   Boolean: whether to enable yplookup, default: false
#
# [*config_file*]
#   String: the bootparams config file, default: /etc/bootparams
#
# [*bootparams*]
#   Hash: the contents that goes into the config file, default: undef
#
class bootparamd::config (
  String $config_file,
  Boolean $enable_yplookup,
  Optional[Hash] $bootparams,
) {
  file { $config_file:
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('bootparamd/bootparams.erb'),
  }
}
