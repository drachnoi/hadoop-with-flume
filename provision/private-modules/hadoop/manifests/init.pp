class hadoop {

  exec { 'download hadoop' :
    command => 'wget -O /tmp/hadoop.tar.gz http://xenia.sote.hu/ftp/mirrors/www.apache.org/hadoop/common/hadoop-3.0.0-alpha1/hadoop-3.0.0-alpha1.tar.gz',
    path    => $path,
    user    => $user,
    group   => $user,
    unless  => "ls ${install_dir} | grep hadoop-3.0.0-alpha1",
  }

  exec { 'unpack hadoop' :
    command => "tar -zxf /tmp/hadoop.tar.gz -C ${install_dir}",
    path    => $path,
    user    => $user,
    group   => $user,
    creates => "${hadoop_home}-3.0.0-alpha1",
    require => Exec['download hadoop'],
  }

  file { "/var/lib" :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => 777,
	  require => [ Exec['apt-get update'] ],
  }

  file { "/var/lib/hadoop" :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => 777,
	  require => [ Exec['apt-get update'], File["/var/lib"] ],
  }

  file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/core-site.xml" :
    source  => 'puppet:///modules/hadoop/core-site.xml',
    mode    => 644,
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
  }

  file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/mapred-site.xml" :
    source  => 'puppet:///modules/hadoop/mapred-site.xml',
    mode    => 644,
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
   }

   file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/hdfs-site.xml" :
    source  => 'puppet:///modules/hadoop/hdfs-site.xml',
    mode    => 644,
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
   }

  file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/hadoop-env.sh" :
    source  => 'puppet:///modules/hadoop/hadoop-env.sh',
    mode    => 644,
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
  }
}
