class profile::hadoop::hadoop (
    $user        = undef,
    $install_dir = undef
  ) {

  class { 'profile::hadoop::ssh' :
    user => $user,
  }

  class { 'hadoop' :
    user        => $user,
    install_dir => $install_dir,
    hadoop_home => "${install_dir}/hadoop",
  }
}
