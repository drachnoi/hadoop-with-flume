$user = "hadoop"
$group = "hadoop"
$install_dir = "/home/${user}"
$hadoop_home = "${install_dir}/hadoop"
$flume_home = "${install_dir}/flume"

include apt
include ssh
include hadoop
include flume

file { "/home/${user}" :
  ensure  => directory,
  owner   => $user,
  group   => $group,
  mode    => 700,
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

apt::ppa { 'ppa:webupd8team/java': }

exec { 'apt-get update' :
  command => '/usr/bin/apt-get update',
  require => [ Apt::Ppa['ppa:webupd8team/java'] ],
}

class { 'java_binary' :
  repository            => 'webupd8team',
  distribution          => 'oracle',
  release               => 'java8',
  accept_oracle_license => true,
  require               => Exec['apt-get update']
}
