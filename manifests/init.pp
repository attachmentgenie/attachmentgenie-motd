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
    ensure         => present,
    ensure_newline => true,
    owner          => root,
    group          => root,
    mode           => '0755',
  }

  concat::fragment{'motd_os_header':
    target  => $motd_file,
    content => template('motd/os.erb'),
    order   => '01',
  }

  concat::fragment{'motd_puppet_header':
    target  => $motd_file,
    content => "Puppet environment: ${::environment}",
    order   => '02',
  }

  concat::fragment{'motd_modules_header':
    target  => $motd_file,
    content => 'Puppet modules on this server:',
    order   => '03',
  }
}
