define bootparamd::config (
  $nfsserver,
  $nfspath,
  $hostname = $title,
) {
  include bootparamd::params
  concat::fragment { "bootparamd-config-${hostname}":
    order      => '01',
    target     => $bootparamd::config_file,
    content    => template('bootparamd/bootparams.erb'),
  }
}
