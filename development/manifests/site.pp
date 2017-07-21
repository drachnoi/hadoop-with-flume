$user = "hadoop"
$group = "hadoop"
$install_dir = "/home/${user}"
$hadoop_home = "${install_dir}/hadoop"
$flume_home = "${install_dir}/flume"

include apt
include hadoop
include flume

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

exec { 'apt-get update' :
  command => '/usr/bin/apt-get update',
}

class { 'java' :
  require => Exec['apt-get update'],
}

ssh_keygen { $user: }

exec { "copy public key" :
  command => "/bin/cp /home/${user}/.ssh/id_rsa.pub /home/${user}/.ssh/authorized_keys",
  require => [Ssh_keygen[$user], File["/home/${user}"] ],
}
