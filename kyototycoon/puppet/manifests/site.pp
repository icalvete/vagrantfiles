stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  class {'roles::kyototycoon_server':
    memcached => true
  }
}

