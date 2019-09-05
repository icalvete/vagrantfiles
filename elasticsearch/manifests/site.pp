stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = lookup('environment')

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env
  }

  include php5::php5_cli

  $repo_version = '6.x'

  class {'roles::elasticsearch_server':
    repo_version     => $repo_version,
    version          => '6.6.0',
    bind_host        => $ipaddress_enp0s8,
    publish_host     => $ipaddress_enp0s8,
    default_template => false
  }
}
