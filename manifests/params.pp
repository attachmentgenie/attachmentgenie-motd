class motd::params() {
  case $::osfamily {
    'debian': {
      case $::lsbdistcodename {
        'precise', 'trusty': {
          $motd_file = '/etc/motd.tail'
        }
        default: {
          $motd_file = '/etc/motd'
        }
      }
    }
    'redhat': {
      $motd_file = '/etc/motd'
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}")
    }
  }
}
