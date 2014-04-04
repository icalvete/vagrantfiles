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
    phalcon => true
  }

  class{'roles::syslog_sender_server':
    syslog_remote_server => '192.168.33.5'
  }
}
