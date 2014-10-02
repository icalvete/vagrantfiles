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

  class {'roles::kyototycoon_server':
    memcached => true
  }
}

