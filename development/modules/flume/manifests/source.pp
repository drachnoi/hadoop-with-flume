define flume::source (
  $path_to_repo = undef,
  $user         = undef
  ){

  class { 'git' : }

  exec { 'clone repository' :
    cwd      => $path_to_repo,
    command  => "git clone https://github.com/cloudera/cdh-twitter-example.git",
    path    => "/usr/local/bin/:/usr/bin:/bin/",
    user    => $user,
    require  => Class['git'],
    unless   => "ls ${path_to_repo}/cdh-twitter-example | grep flume-sources",
  }

  class { 'maven::maven' : }

  exec { 'build flume source' :
    cwd     => "${path_to_repo}/cdh-twitter-example/flume-sources",
    command => "mvn clean install",
    path    => "/usr/local/bin/:/usr/bin:/bin/",
    user    => $user,
    require => [Exec['clone repository'], Class['maven::maven']],
  }

  exec { 'move flume source to lib folder' :
    cwd      => $path_to_repo,
    command => "cp cdh-twitter-example/flume-sources/target/flume-sources-1.0-SNAPSHOT.jar lib/",
    path    => "/usr/local/bin/:/usr/bin:/bin/",
    user    => $user,
    require  => Exec['build flume source'],
    unless   => "ls ${path_to_repo}/lib | grep flume-sources-1.0-SNAPSHOT.jar",
  }
}
