class hadoop (
    $user             = undef,
    $install_dir_path = undef,
    $hadoop_dir_name  = undef,
    $download_mirror  = undef
  ){

  $hadoop_home = "${install_dir_path}/${hadoop_dir_name}"

  exec { 'download hadoop' :
    command => "wget -O /tmp/hadoop.tar.gz ${download_mirror}",
    path    => $path,
    user    => $user,
    group   => $user,
    unless  => "ls ${install_dir_path} | grep ${hadoop_dir_name}",
  }

  exec { 'unpack hadoop' :
    command => "tar -zxf /tmp/hadoop.tar.gz -C ${install_dir_path}",
    path    => $path,
    user    => $user,
    group   => $user,
    creates => "${hadoop_home}",
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

  file { "${hadoop_home}/etc/hadoop/core-site.xml" :
    source  => 'puppet:///modules/hadoop/core-site.xml',
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
  }

  file { "${hadoop_home}/etc/hadoop/mapred-site.xml" :
    source  => 'puppet:///modules/hadoop/mapred-site.xml',
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
   }

   file { "${hadoop_home}/etc/hadoop/hdfs-site.xml" :
    source  => 'puppet:///modules/hadoop/hdfs-site.xml',
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
   }

  file { "${hadoop_home}/etc/hadoop/hadoop-env.sh" :
    content => template('hadoop/hadoop-env.sh.erb'),
    mode    => '0644',
    owner   => $user,
    group   => $user,
    require => Exec['unpack hadoop'],
  }

  exec { 'append hadoop to path' :
    command => "echo export PATH=\$PATH:${hadoop_home}/bin >> /home/${user}/.bashrc",
    path    => $path,
    require => Exec['unpack hadoop'],
  }
}
