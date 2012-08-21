class ssh {
  package { 'openssh':
    ensure => latest,
  }

  service { 'sshd':
    ensure     => running,
    # Use reload instead of restart so the session is maintained
    restart    => '/etc/init.d/ssh reload',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  file { 'sshd_config':
    ensure  => present,
    path    => '/etc/ssh/sshd_config',
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => 'puppet:///modules/ssh/sshd_config',
    notify  => Service['sshd'],
  }
}

