stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  class {'roles::apache2_server':
    phalcon => true
  }
}

