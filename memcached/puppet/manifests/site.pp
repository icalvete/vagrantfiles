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

  class {'roles::memcached_server':
    memory          => '256',
    max_object_size => '3m'
  }
}

