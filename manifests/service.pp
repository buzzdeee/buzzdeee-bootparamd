# Private class, do not use directly.
# Takes care about managing the service.

class bootparamd::service (
  $service_enable,
  $service_ensure,
  $service_flags,
  $service_name,
){

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
