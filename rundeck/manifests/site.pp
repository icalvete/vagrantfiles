stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = lookup('environment')

node default {


  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

$env = lookup('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env
  }

  include rundeck
}
