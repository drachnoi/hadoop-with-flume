class profile::java::jdk8 {

  class { 'apt' : }

  exec { 'apt-get update' :
    command => '/usr/bin/apt-get update',
  }

  class { 'java' :
    require => Exec['apt-get update'],
  }
}
