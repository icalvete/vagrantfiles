stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  class {'roles::apache2_server':
    phalcon           => true,
    file_uploads      => 'On',
    file_uploads_size => '10M'
  }

  apache2::site{'core.vhost.conf':
    source  => 'axn-server-finder/core.vhost.conf.erb',
    require => Class['roles::apache2_server']
  }

  apache2::site{'api.vhost.conf':
    source  => 'axn-server/api.vhost.conf.erb',
    require => Class['roles::apache2_server']
  }

  class{'roles::syslog_sender_server':
    syslog_remote_server => '192.168.33.5'
  }
}
