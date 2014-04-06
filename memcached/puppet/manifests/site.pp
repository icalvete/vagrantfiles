stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  class {'roles::memcached_server':
    memory          => '256',
    max_object_size => '3m'
  }
}

