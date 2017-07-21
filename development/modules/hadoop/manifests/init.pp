class hadoop (
    $user             = undef,
    $install_dir      = undef,
    $hadoop_home      = undef,
    $download_mirror  = undef
  ){

  exec { 'download hadoop' :
    command => "wget -O /tmp/hadoop.tar.gz ${download_mirror}",
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
  }

  file { '/var/lib' :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0777',
  }

  file { '/var/lib/hadoop' :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0777',
	  require => File["/var/lib"],
  }

  file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/core-site.xml" :
    source  => 'puppet:///modules/hadoop/core-site.xml',
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
  }

  file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/mapred-site.xml" :
    source  => 'puppet:///modules/hadoop/mapred-site.xml',
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
   }

   file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/hdfs-site.xml" :
    source  => 'puppet:///modules/hadoop/hdfs-site.xml',
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
   }

  file { "${hadoop_home}-3.0.0-alpha1/etc/hadoop/hadoop-env.sh" :
    content => template('flume/flume-env.sh.erb'),
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
  }
}
