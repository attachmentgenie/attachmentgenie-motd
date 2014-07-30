# Class: puppet-motd
#
# This module manages puppet-motd.
# Currently this is only the module version of the ripienaar/concat example.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   class { 'motd': }
#   motd::register{'Apache': }
class motd (
  $motd_file = $motd::params::motd_file,
) inherits ::motd::params {

  concat{$motd_file:
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755
  }

  concat::fragment{"motd_puppet_header":
    target  => $motd_file,
    content => "\nPuppet environment: $environment\n",
    order   => 01,
  }

  concat::fragment{'motd_header':
    target  => $motd_file,
    content => "\nPuppet modules on this server:\n\n",
    order   => 02,
  }
}
