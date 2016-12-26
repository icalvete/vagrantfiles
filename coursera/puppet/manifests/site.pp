stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  class {'common::vagrant':
    stage => pre
  }

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  class {'nodejs':
    version => 4
  }
  
  $backup_dir = hiera('backup_dir')

  file {'backup_dir':
    ensure => directory,
    path   => $backup_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  class {'::mongodb::globals':
    version             => '3.2.7',
    manage_package_repo => true,
    bind_ip             => '0.0.0.0'
  }->
  class {'::mongodb::client': }->
  class {'::mongodb::server':
    verbose       => true,
    require       => Class['mongodb::globals']
  }

  package { 'mongodb-org-tools':
    ensure  => present,
    require => Class['mongodb::server']
  }
}
