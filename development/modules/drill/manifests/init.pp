class drill (
  $user                = undef,
  $download_mirror     = undef,
  $install_dir_path    = undef,
  $drill_dir_name      = undef
  ){

  $drill_home = "${drill_dir_path}/${drill_dir_name}"

  exec { 'download drill' :
    command => "wget -O /tmp/drill.tar.gz ${download_mirror}",
    path    => $path,
    user    => $user,
    group   => $user,
  }

  exec { 'unpack drill' :
    command => "tar -zxf /tmp/drill.tar.gz -C ${install_dir_path}",
    path    => $path,
    user    => $user,
    group   => $user,
    creates => "${drill_home}",
    require => Exec['download drill'],
  }
}
