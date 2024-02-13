# Private class, do not use directly.
# Takes care about the syctl, net.inet.ip.portlast,
# required to boot old SGI boxes.
#
# [*old_sgi_client*]
#   Boolean: enables sysctl to lock down high ports for bootparamd
#   to listen on. default: false
#
class bootparamd::sysctl (
  Boolean $old_sgi_client,
) {
  if $old_sgi_client {
    sysctl { 'net.inet.ip.portlast':
      ensure => 'present',
      value  => '32767',
    }
  }
}
