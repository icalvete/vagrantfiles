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
    set_parameter => ['failIndexKeyTooLong: false', 'textSearchEnabled: true'],
    require       => Class['mongodb::globals']
  }

  package { 'mongodb-org-tools':
    ensure  => present,
    require => Class['mongodb::server']
  }

  include nodejs

  parse_platform::app {'app1':
    application_id => '111',
    master_key     => '111',
    require        => Class['nodejs']
  }

  parse_platform::app {'app2':
    application_id   => '222',
    master_key       => '222',
    port             => 1338,
    cloud_code       => true,
    cloud_repository => 'https://github.com/Npmorales/Cloud_code.git',
    dashboard        => true,
    javascript_key   => '222',
    rest_key         => '222',
    dashboard_user   => 'user',
    dashboard_pass   => 'pass',
    require          => Class['nodejs']
  }
}
