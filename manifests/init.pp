# Class: attachmentgenie-motd
#
# This module manages attachmentgenie-motd.
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
class motd {
  include concat::setup
  $motd = '/etc/motd.tail'

  concat{$motd:
    owner => root,
    group => root,
    mode  => 755
  }

  concat::fragment{'motd_header':
    target  => $motd,
    content => "\nPuppet modules on this server:\n\n",
    order   => 01,
  }
}

# used by other modules to register themselves in the motd
define motd::register($content='', $order=10) {
  if $content == '' {
    $body = $name
  } else {
    $body = $content
  }

  concat::fragment{'motd_fragment_$name':
    target  => "/etc/motd.tail",
    content => "    -- $body\n",
  }
}
