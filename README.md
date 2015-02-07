#vagrantfiles

Vagrant files to build some service boxes

**All Vagrant Files are configured to use https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-puppet as box. Feel free to customize files**

## Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/smartpurposes/puppet-modules

## Installation:

[Common]

* Install Virtual Box => 4.3.6 from https://www.virtualbox.org/wiki/Downloads
* Install Vagrant 1.6.5 from http://www.vagrantup.com/downloads

[\*NIX]

* Install git

[Windows]

* Install cygwin from http://cygwin.com/install.html ( No mandatory  but really usefull )
* Install git on cygwin

**Reboot if don't did it after Virtual Box and Vagrant**

[Common]

### Add boxes:
* Download boxes

Choose the right backend (In this case, virtualbox)
See the example at the end of the seccion.

```bash
$ vagrant box add https://vagrantcloud.com/puppetlabs/boxes/ubuntu-12.04-64-puppet
$ vagrant box add https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-puppet 
```

Chossing the right backend (virtualbox)

```bash
$ vagrant box add https://vagrantcloud.com/puppetlabs/boxes/centos-7.0-64-puppet
==> box: Loading metadata for box 'https://vagrantcloud.com/puppetlabs/boxes/centos-7.0-64-puppet'
This box can work with multiple providers! The providers that it
can work with are listed below. Please review the list and choose
the provider you will be working with.

1) virtualbox
2) vmware_desktop
3) vmware_fusion

Enter your choice: 1
==> box: Adding box 'puppetlabs/centos-7.0-64-puppet' (v1.0.0) for provider: virtualbox
    box: Downloading: https://vagrantcloud.com/puppetlabs/boxes/centos-7.0-64-puppet/versions/1.0.0/providers/virtualbox.box
    box:
```

### Setting up the environment

[Common]

* Download this project:

```bash
$ git clone https://github.com/icalvete/vagrantfiles.git 
```


* Download common manifest

```bash
$ cd  vagrantfiles
$ mkdir puppet/modules_sp
$ cd puppet/modules_sp
$ git clone https://github.com/smartpurposes/puppet-modules.git .
$ git submodule init
$ git submodule update
```

* Download any manifest you need

```bash
$ cd ..
$ mkdir puppet/modules
$ cd puppet/modules
$ git clone  https://< what ever you need >.git
```

## Using it:

* Run any service box  (kyototycoon for example)


```bash
$ cd  vagrantfiles/kyototycoon
$ vagrant up
```

* Connecting to service box:

```bash
$ vagrant ssh
```

## Extend this service boxes:

* Create _< where ever >vagrantfiles/puppet/modules_ and put your own puppet manifests here.
* Change any _< where ever >/vagrantfiles/< service box >/puppet/manifests/site.pp_ to extend it.


## Hiera:

**Some service box (mysql, rabbitmq...) are using manifest who needs hiera.**

Put your hiera file in _< where ever >/vagrantfiles/puppet/hiera/common.yaml_

[hiera example](https://github.com/icalvete/vagrantfiles/blob/master/puppet/hiera/common.yaml)


## Authors:

Israel Calvete Talavera <icalvete@gmail.com>
