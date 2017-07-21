class flume (
  $consumer_key        = undef,
  $consumer_key_secret = undef,
  $access_token        = undef,
  $access_token_secret = undef,
  $user                = undef,
  $install_dir         = undef,
  $flume_home          = undef
  ){

  exec { 'download flume' :
    command => 'wget -O /tmp/flume.tar.gz http://xenia.sote.hu/ftp/mirrors/www.apache.org/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz',
    path    => $path,
    user    => $user,
    group   => $user,
  }

  exec { 'unpack flume' :
    command => "tar -zxf /tmp/flume.tar.gz -C ${install_dir}",
    path    => $path,
    user    => $user,
    group   => $user,
    creates => "${flume_home}-1.7.0",
    require => Exec['download flume'],
  }

  file { '/home/hadoop/apache-flume-1.7.0-bin/conf/flume-conf.properties' :
    ensure  => file,
    content => template('flume/flume-conf.properties.erb'),
    require => Exec['unpack flume'],
  }

  file { '/home/hadoop/apache-flume-1.7.0-bin/conf/flume-env.sh' :
    ensure  => file,
    content => template('flume/flume-env.sh.erb'),
    require => Exec['unpack flume'],
  }
}
