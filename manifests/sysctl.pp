# Private class, do not use directly.
# Takes care about the syctl, net.inet.ip.portlast,
# required to boot old SGI boxes.
#
class bootparamd::sysctl {
  if $bootparamd::old_sgi_client {
    sysctl { 'net.inet.ip.portlast':
      ensure => 'present',
      value  => '32767',
    }
  }
}
