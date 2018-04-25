stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = hiera('environment')

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $apache26_dists = hiera('apache26_dists')
  $apache26       = member($apache26_dists, $lsbdistcodename)

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env,
  }

  class {'roles::apache2_server':
    phalcon           => true,
    file_uploads      => 'On',
    file_uploads_size => '10M',
    wsgi              => true
  }

  class{'roles::syslog_sender_server':
    syslog_remote_server => '192.168.33.5'
  }
}
