stage{'pre':}
stage{'post':}

Stage[pre] -> Stage[main] -> Stage[post]

node default {

  include common::virtual

  # Put here your RSA key
  $private_key = '-----BEGIN RSA PRIVATE KEY-----
  MIIEowIBAAKCAQEA3sBYray9Muc3ZKAlTO4lq/n4ZiM7OZrjAgaSahH/UnF9mA5b
  NkVRNU1LlIRQHfteghlbOzvm6cSAx30TriUvjzc1azM1OrX/4SeguLiaQQv8E8M2
  xXRoBC3oy3RVPzPYRM3rE8zaprdH0u3R+aC7Cnhrr25uifrpkV0oVkxSFNCjfJC4
  OxMkyKFWJqGTR0UT/0n989WlAol1ZnkLg2ScDHli7Ui/lDvV9EKIJcBDyh4RoGFU
  EdR7hwNR+SmKW04dINowiqp0N1O6OTfCm+3/iB5K/ViQHBI9N8+5KTvnw129YosS
  hPvKmI2kXQfm26U7w2JJRuv6D1mzdk+63UupqQIDAQABAoIBAHenUvtYAvnJAhRn
  giHk+w96Y1haLIIxFSgNZ7DaohAjLpfzfkOU0J6VOrg4quCwGoBAJqWW89820wZV
  xbCSAQ4pVeSTyVAUW7MSml8fqpyuV2Y2QsGmWgmEr7w6bWBZ9R5gjppAPGO5qDdB
  0L0K/e4N6ap+45ny0mxnYjeZH65VtC2ImZO+aaB2YEGj5p6waiSfq63pxnU3n7rW
  TJMTDdsOJONhyVulgI0xDHUbGsrhzRm4f9D9y5mHGZ/T0VMFS2UtUAHEFn7CBa6H
  /iy0iUMVIHDtqHJWHacY2cXa8kCOHUs0NBVvpWLbRAYQ02OM0vJBd1uCbZT2dxSV
  UrdnEVECgYEA8J2yDCgF+XOyNyClDwYtAhGJHNHW4Igu5tFi1B/An9AWR6VvXygi
  c2ynPjnaJfOd56PSd8TM4LJl30rdNtyf5TI62INR+uGBLJEvpVZTD9Ra8Q0G4u8l
  Qu+nAli4GbAZPrbJ0H1DGo571sR7FFJGuPdVNOxqF3Zq2t4WTkhEjAcCgYEA7P4/
  6yJDq2Iyr7vtnzMcIuEWTrkulbZgGxYxIG3aX1Jvf5BJciBOHohLBikpGyW7H+z8
  C1MgWqOco8JqkaJpAGLLDc3H0cUbnkLpN9pW6ktwBNA/zoKKfLOtfiHWrL6XQ8JJ
  c4Z8t7NEc+i9CgEBRFpJVlih/WusHmlrX2ZyEM8CgYB3+ro4c5CfFYDNGlsTxcmV
  mXbcRwo1hdKVR91W1spvJgymBykksteS5J/0WFady/917Otay2g5ttszX5o07AhS
  +hv7sGeliOKnfXHbqNLcNtBuGEfRytuyp9uIQQLz1CqSagTyEDPwvxGjQu/4bxpS
  ywnSzPwN3P9lSY6n1ENR6wKBgQDL/fFQ2LZ8n9LXNyDLJrgyQaLs8jLqBQhmaEyz
  CDuuTwvQNocxqCL13wUM8YMDbg/K5DbzHIM94ZTj1GXco3pULbVwVU+I/WvPZvLN
  869ajsKGMiap/+1qd1J/vmrFWGxlk6ebvAhAKxth1dRZ9xF7H2f+3d3Zf8Owjbcx
  b8IBOwKBgCgig0EI5zzjV8BWnZcODK4hjHZdEEHJOKyaaiRUi1/c568lmig9ZDwh
  NCDfJWaFPQ7CzZU/M5nzo4tEo34zBhknPsp8IWkO0VBuKqjk0TQQG9VziqtIZjKB
  0fB/vc2xPs+swC+1tlqsZTVTNyQy4FtrTMQRG0IM5TriOy+Su2Uk
  -----END RSA PRIVATE KEY-----'

  $public_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDewFitrL0y5zdkoCVM7iWr+fhmIzs5muMCBpJqEf9ScX2YDls2RVE1TUuUhFAd+16CGVs7O+bpxIDHfROuJS+PNzVrMzU6tf/hJ6C4uJpBC/wTwzbFdGgELejLdFU/M9hEzesTzNqmt0fS7dH5oLsKeGuvbm6J+umRXShWTFIU0KN8kLg7EyTIoVYmoZNHRRP/Sf3z1aUCiXVmeQuDZJwMeWLtSL+UO9X0QoglwEPKHhGgYVQR1HuHA1H5KYpbTh0g2jCKqnQ3U7o5N8Kb7f+IHkr9WJAcEj03z7kpO+fDXb1iixKE+8qYjaRdB+bbpTvDYklG6/oPWbN2T7rdS6mp jenkins@jenkins'

  $environment = hiera('environment')

  common::add_env{'APPLICATION_ENV':
    key   => 'APPLICATION_ENV',
    value => $environment
  }

  class {'roles::jenkins_server':
    repo_resource => 'jenkins_1.544_all.deb',
  }

  $jenkins_ssh_dir = "${jenkins::params::config_path}/.ssh"

  file{ 'jenkins_ssh_dir':
    ensure  => directory,
    path    => $jenkins_ssh_dir,
    owner   => 'jenkins',
    group   => $jenkins::params::group,
    mode    => '0700',
    require => Class['roles::jenkins_server']
  }

  file{ 'jenkins_private_ssh_key':
    ensure  => present,
    path    => "${jenkins_ssh_dir}/id_rsa",
    content => $private_key,
    owner   => 'jenkins',
    group   => $jenkins::params::group,
    mode    => '0600',
    require => File['jenkins_ssh_dir']
  }

  file{ 'jenkins_public_ssh_key':
    ensure  => present,
    path    => "${jenkins_ssh_dir}/id_rsa.pub",
    content => $public_key,
    owner   => 'jenkins',
    group   => $jenkins::params::group,
    mode    => '0644',
    require => File['jenkins_ssh_dir']
  }
}
