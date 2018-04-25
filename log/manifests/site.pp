stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = hiera('environment')

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env,
  }

  include roles::elasticsearch_server
  include roles::syslog_remote_server
  include roles::kibana_server

  class{'roles::syslog_sender_server':
    syslog_remote_server => '127.0.0.1'
  }

  class { 'roles::td_agent_server':
    elasticsearch_host => '127.0.0.1'
  }
}

