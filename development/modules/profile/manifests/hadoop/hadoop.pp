class profile::hadoop::hadoop (
    $user        = undef,
    $install_dir = undef
  ) {

  class { 'profile::hadoop::ssh' :
    user => $user,
  }

  class { 'hadoop' :
    user              => $user,
    install_dir_path  => $install_dir,
  }
}
