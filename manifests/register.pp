define motd::register(
  $content= '',
  $order  = 10,
  $target = $motd::params::motd_file,
) {
  include motd::params

  if $content == '' {
    $body = $name
  } else {
    $body = $content
  }

  concat::fragment{"motd_fragment_$name":
    target  => $target,
    content => "    -- $body\n",
  }
}