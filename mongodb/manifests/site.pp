stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = lookup('environment')

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env
  }

  $backup_dir = lookup('backup_dir')

  file {'backup_dir':
    ensure => directory,
    path   => $backup_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  class {'roles::mongodb_server':
    version    => '4.2.0',
    auth       => false,
    backup_dir => $backup_dir,
    rest       => false,
    set_parameter => '
  failIndexKeyTooLong: false
    '
  }
}

