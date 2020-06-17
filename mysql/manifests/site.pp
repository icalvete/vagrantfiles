stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

$env = lookup('environment')

node default {

  include common
  common::set_localtime{'set_localtime':
    zone => 'Europe/Madrid'
  }

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $env
  }

  $ruby_packages = ['ruby', 'ruby-dev', 'build-essential', 'libsqlite3-dev', 'zlib1g-dev']

  package {$ruby_packages:
    ensure => present
  }

  $root_pass  = lookup('mysql_root_pass')
  $backup_dir = lookup('backup_dir')

  file {'backup_dir':
    ensure => directory,
    path   => $backup_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  $override_options = {
    'mysqld' => {
      'bind-address' => '0.0.0.0',
    }
  }

  class { '::mysql::server':
    root_password           => $root_pass,
    remove_default_accounts => true,
    restart                 => true,
    override_options        => $override_options
  }
}

