# Private class, do not use directly.
# Takes care about managing the service.
#
class bootparamd::service {
  if ! defined(Service['portmap']) {
    include portmap
  }
  service { $bootparamd::service_name:
    ensure     => $bootparamd::service_ensure,
    enable     => $bootparamd::service_enable,
    hasrestart => true,
    hasstatus  => true,
    flags      => $bootparamd::service_flags,
  }

  Service['portmap']
  -> Service[$bootparamd::service_name]
}
