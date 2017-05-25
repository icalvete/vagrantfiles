stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment
  }

  include php5::php5_cli

  $repo_version = '5.x'

  class {'roles::elasticsearch_server':
    java_install     => true,
    repo_version     => $repo_version,
    bind_host        => $ipaddress_enp0s8,
    publish_host     => $ipaddress_enp0s8,
    default_template => false
  }
}
