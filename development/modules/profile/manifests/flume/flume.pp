class profile::flume::flume (
    $user        = undef,
    $install_dir = undef,
  ) {

  class { 'flume' :
    user             => $user,
    install_dir_path => $install_dir,
  }
}
