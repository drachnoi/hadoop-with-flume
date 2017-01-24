class ssh {

  file { "/home/${user}/.ssh" :
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => 750,
	  require => [File["/home/${user}"] ],
  }

  file { "/home/${user}/.ssh/id_rsa" :
    source  => 'puppet:///modules/ssh/id_rsa',
    ensure  => present,
    mode    => 600,
    owner   => $user,
    group   => $user,
    require => File["/home/${user}/.ssh"],
   }

  file { "/home/${user}/.ssh/id_rsa.pub" :
    source  => 'puppet:///modules/ssh/id_rsa.pub',
    ensure  => present,
    mode    => 644,
    owner   => $user,
    group   => $user,
    require => File["/home/${user}/.ssh"],
  }

  file { "/home/${user}/.ssh/authorized_keys" :
    source => 'puppet:///modules/ssh/id_rsa.pub',
    ensure => present,
    mode => 600,
    owner => $user,
    group => $user,
    require => File["/home/${user}/.ssh"],
  }

  ssh_authorized_key { "ssh key":
    ensure  => present,
    key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCeHdBPVGuSPVOO+n94j/Y5f8VKGIAzjaDe30hu9BPetA+CGFpszw4nDkhyRtW5J9zhGKuzmcCqITTuM6BGpHax9ZKP7lRRjG8Lh380sCGA/691EjSVmR8krLvGZIQxeyHKpDBLEmcpJBB5yoSyuFpK+4RhmJLf7ImZA7mtxhgdPGhe6crUYRbLukNgv61utB/hbre9tgNX2giEurBsj9CI5yhPPNgq6iP8ZBOyCXgUNf37bAe7AjQUMV5G6JMZ1clEeNPN+Uy5Yrfojrx3wHfG40NuxuMrFIQo5qCYa3q9/SVOxsJILWt+hZ2bbxdGcQOd9AXYFNNowPayY0BdAkSr",
    type    => "ssh-rsa",
    user    => $user,
    require => File["/home/${user}/.ssh/id_rsa.pub"],
  }

  file { "/home/${user}/.ssh/config" :
    owner => $user,
    group => $group,
    mode => 755,
    content => 'StrictHostKeyChecking no',
    require => File["/home/${user}/.ssh/id_rsa.pub"],
  }
}
