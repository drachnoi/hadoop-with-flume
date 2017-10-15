class role::hadoop::singlenode (
    $user        = undef,
    $group       = undef,
    $install_dir = undef,
  ){

    class { 'profile::java::jdk8' : }

    class { 'profile::hadoop::hadoop' :
      user        => $user,
      install_dir => $install_dir,
    }

    class { 'profile::flume::flume' :
      user        => $user,
      install_dir => $install_dir,
    }

    class { 'profile::drill::drill' :
      user        => $user,
      install_dir => $install_dir,
    }
}
