node 192.168.33.15 {
  $user = hiera('user')
  $group = hiera('group')
  $install_dir = hiera('install_dir')


  file { "/home/${user}" :
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0700',
    require =>  [ User[$user], Group[$group] ],
  }

  group { $group :
    ensure => 'present',
  }

  user { $user :
    ensure     => 'present',
    home       => "/home/${user}",
    name       => $user,
    shell      => '/bin/bash',
    password   => 'hadoop',
    managehome => true,
    gid        => $group,
  }
  
  class { 'role::hadoop::singlenode' :
    user        => $user,
    group       => $group,
    install_dir => $install_dir
  }
}
