stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  package{'software-properties-common':}
  package{'git':}
  
  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  include roles::nifi_server
}
