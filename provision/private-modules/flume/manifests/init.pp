class flume {

  exec { 'download flume' :
    command => 'wget -O /tmp/flume.tar.gz http://xenia.sote.hu/ftp/mirrors/www.apache.org/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz',
    path    => $path,
    user    => $user,
    group   => $user,
    unless  => "ls ${install_dir} | grep flume-1.7.0",
  }

  exec { 'unpack flume' :
    command => "tar -zxf /tmp/flume.tar.gz -C ${install_dir}",
    path    => $path,
    user    => $user,
    group   => $user,
    creates => "${flume_home}-1.7.0",
    require => Exec['download flume'],
  }
}
