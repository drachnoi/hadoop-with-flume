class profile::flume::flume (
    $user        = undef,
    $install_dir = undef,
  ) {

  class { 'flume' :
    user        => $user,
    install_dir => $install_dir,
    flume_home => "${install_dir}/flume"
  }
}
