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

  $ruby_packages = ['ruby', 'ruby-dev', 'build-essential', 'libsqlite3-dev', 'zlib1g-dev']

  package {$ruby_packages:
    ensure => present
  }

  $root_user  = lookup('mysql_root_user')
  $root_pass  = lookup('mysql_root_pass')
  $backup_dir = lookup('backup_dir')

  file {'backup_dir':
    ensure => directory,
    path   => $backup_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  class {'mysql::server':
    root_pass  => 'mysql',
    backup_dir => '/srv/backup',
    s3_backup  => false,
    require    => File['backup_dir']
  }

  mysql::user {'root':
    root_user => $root_user,
    root_pass => $root_pass,
    pass      => $root_pass,
    host      => '%',
    require   => Class['mysql::server']
  }
}

