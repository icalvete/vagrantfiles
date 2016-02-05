stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  #class {'common::vagrant':
  #  stage => pre
  #}

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment
  }

  include php5

  class {'roles::elasticsearch_server':
    version      => '2.2.0',
    hosts        => ['192.168.33.19', '192.168.33.20'],
    bind_host    => $ipaddress_eth1,
    publish_host => $ipaddress_eth1,
  }
}
