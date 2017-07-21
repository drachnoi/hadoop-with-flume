class profile::hadoop::ssh (
    $user = undef
  ){

  ssh_keygen { $user : }

  exec { "copy public key" :
    command => "/bin/cp /home/${user}/.ssh/id_rsa.pub /home/${user}/.ssh/authorized_keys",
    require => [Ssh_keygen[$user], File["/home/${user}"] ],
  }
}
