class profile::drill::drill (
    $user        = undef,
    $install_dir = undef,
  ) {

  class { 'drill' :
    user             => $user,
    install_dir_path => $install_dir,
  }
}
