stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  include common

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
  
  class {'roles::mongodb_server':
    auth          => false,
    backup_dir    => $backup_dir,
    rest          => false
  }
}
