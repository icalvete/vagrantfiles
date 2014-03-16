stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment,
  }

  include ccore

  class {'roles::apache2_server':
    phalcon => true
  }

  if $php5::params::environment == 'DEV' {

    $package = ['php5-dev', 'swig']
    package {$package:
      ensure  => present
    }
  }
}

