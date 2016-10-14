stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  include ntp

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  common::add_env{'RAILS_ENV':
    key   => 'RAILS_ENV',
    value => 'development',
  }

  common::add_env{'RACK_ENV':
    key   => 'RAILS_ENV',
    value => 'development',
  }

  exec { 'installing_heroku_tools':
    command  => 'wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh',
    user     => 'root',
    unless   => '/usr/bin/dpkg -l heroku-toolbelt | grep ii',
    provider => shell
  }

  class {'roles::memcached_server':
    memory          => '256',
    max_object_size => '3m'
  }
}
