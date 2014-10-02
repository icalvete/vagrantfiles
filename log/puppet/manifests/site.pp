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

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  include common::virtual
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

