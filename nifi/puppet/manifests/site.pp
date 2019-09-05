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
    value => $environment,
  }

  class {'roles::nifi_server':
    auth                   => 'cert',
    keystore_file_source   => 'https://ec2-34-248-158-248.eu-west-1.compute.amazonaws.com/keystore.jks',
    keystore_password      => 'SuperSecret',
    admin                  => 'CN=admin, DC=nifi, DC=com',
    truststore_file_source => 'https://ec2-34-248-158-248.eu-west-1.compute.amazonaws.com/truststore.jks',
    truststore_password    => 'SuperSecret'
  }

  nifi_pg {'test':
    ensure        => present,
    secure        => true,
    cert          => '/tmp/admin-cert.pem',
    cert_key      => '/tmp/admin-private-key.pem',
    cert_password => 'SuperSecret'
  }

  nifi_template {'IN.hmStaff.taskStatus.xml':
    ensure        => present,
    path          => 'https://elrond.fluzo.com/IN.hmStaff.taskStatus.xml',
    secure        => true,
    cert          => '/tmp/admin-cert.pem',
    cert_key      => '/tmp/admin-private-key.pem',
    cert_password => 'SuperSecret'
  }
}
