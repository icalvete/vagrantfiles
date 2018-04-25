stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = hiera('environment')

node default {

  include common
  include java
  include ruby::dev

  package { ['libcurl4-openssl-dev', 'zlib1g-dev']:
    ensure  => present
  }

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env,
  }

  # host_header param is due to host header check in 1.5.0
  class {'nifi':
    host_header => '192.168.33.18',
  }
}
