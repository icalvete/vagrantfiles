stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  include common::virtual
  include roles::elasticsearch_server
  include roles::syslog_remote_server
  include roles::kibana_server

  class { 'roles::td_agent_server':
    config_template    => 'fluentd/volta.conf.erb',
    elasticsearch_host => '127.0.0.1'
  }
}

