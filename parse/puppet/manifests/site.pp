stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  package { 'build-essential':
    ensure  => present
  }

  include common
  include nodejs

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $environment = hiera('environment')

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

  parse_platform::app {'app1':
    application_id => '111',
    master_key     => '111',
    cloud_code       => true,
    require        => Class['nodejs']
  }

  parse_platform::app {'app2':
    application_id   => '222',
    master_key       => '222',
    port             => 1338,
    cloud_code       => true,
    dashboard        => true,
    javascript_key   => '222',
    rest_key         => '222',
    dashboard_user   => 'user',
    dashboard_pass   => 'pass',
    require          => Class['nodejs']
  }
}
