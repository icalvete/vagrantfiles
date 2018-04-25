stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  include common

  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  class { '::redis':
    bind        => $ipaddress_enp0s8,
    manage_repo => true,
  }

  class { 'sensu':
    rabbitmq_host     => '192.168.33.12',
    rabbitmq_user     => 'admin',
    rabbitmq_password => 'admin',
    server            => true,
    api               => true,
    plugins           => [
      'puppet:///data/sensu/plugins/ntp.rb',
      'puppet:///data/sensu/plugins/postfix.rb'
    ]
  }
}

