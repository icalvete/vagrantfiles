stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = lookup('environment')

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $apache26_dists = lookup('apache26_dists')
  $apache26       = member($apache26_dists, $lsbdistcodename)

  $php_version = 7

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env,
  }

  include roles::memcached_server

  class {'roles::apache2_server':
    php                    => $php_version,
    passenger              => false,
    wsgi                   => true,
    file_uploads           => 'On',
    file_uploads_size      => '64M',
    max_execution_time_fpm => '60'
  }

  class{'roles::syslog_sender_server':
    syslog_remote_server => '192.168.33.5'
  }
}
