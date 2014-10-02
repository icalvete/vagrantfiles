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

  $root_user  = hiera('mysql_root_user')
  $root_pass  = hiera('mysql_root_pass')
  $backup_dir = hiera('backup_dir')

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

