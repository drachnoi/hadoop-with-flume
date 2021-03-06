class flume (
  $consumer_key        = undef,
  $consumer_key_secret = undef,
  $access_token        = undef,
  $access_token_secret = undef,
  $hdfs_path           = undef,
  $hadoop_prefix       = undef,
  $twitter_keywords    = undef,
  $user                = undef,
  $download_mirror     = undef,
  $install_dir_path    = undef,
  $flume_dir_name      = undef
  ){

  $flume_home = "${install_dir_path}/${flume_dir_name}"

  exec { 'download flume' :
    command => "wget -O /tmp/flume.tar.gz ${download_mirror}",
    path    => $path,
    user    => $user,
    group   => $user,
  }

  exec { 'unpack flume' :
    command => "tar -zxf /tmp/flume.tar.gz -C ${install_dir_path}",
    path    => $path,
    user    => $user,
    group   => $user,
    creates => $flume_home,
    require => Exec['download flume'],
  }

  file { "${flume_home}/conf/flume-conf.properties" :
    ensure  => file,
    owner   => $user,
    group   => $user,
    content => template('flume/flume-conf.properties.erb'),
    require => Exec['unpack flume'],
  }

  file { "${flume_home}/conf/flume-env.sh" :
    ensure  => file,
    owner   => $user,
    group   => $user,
    content => template('flume/flume-env.sh.erb'),
    require => Exec['unpack flume'],
  }

  flume::source { 'twitter source' :
    path_to_repo => $flume_home,
    user         => $user,
  }
}
