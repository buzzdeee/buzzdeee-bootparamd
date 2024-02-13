# Private class, do not use directly.
# Takes care about managing the service.
#
# [*service_enable*]
#   Boolean: whether to enable the service or not, default: true
#
# [*service_ensure*]
#   Enum[running, stopped]: the desired state of bootparamd, default: running
#
# [*service_flags*]
#   String: the service flags, default: '-s'
#
# [*service_name*]
#   String: the name of the service, default: bootparamd
#
class bootparamd::service (
  Boolean $service_enable,
  Enum[running, stopped, 'running', 'stopped'] $service_ensure,
  String $service_flags,
  String $service_name,
) {
  if ! defined(Service['portmap']) {
    include portmap
  }
  service { $service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => true,
    hasstatus  => true,
    flags      => $service_flags,
  }

  Service['portmap']
  -> Service[$service_name]
}
