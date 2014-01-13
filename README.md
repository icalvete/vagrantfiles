#vagrantfiles

Vagrant files to build some service boxes

**All Vagrant Files are configured to use saucy64 as box. Feel free to customize files**

## Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/smartpurposes/puppet-modules

## Installation:

[Common]

* Install Virtual Box  4.3.6 from https://www.virtualbox.org/wiki/Downloads
* Install Vagrant 1.4.2 from http://www.vagrantup.com/downloads

[\*NIX]

* Install git

[Windows]

* Install cygwin from http://cygwin.com/install.html ( No mandatory  but really usefull )
* Install git on cygwin

**Reboot if don't did it after Virtual Box and Vagrant**

[Common]

* Download boxes (precise64.box, raring64.box,  saucy64.box)

**[Boxes uptated at 01/2014 with latest puppet can be found here](https://drive.google.com/folderview?id=0B7WTTQeWTJErRGFUUlUzaW9OSW8&usp=sharing)**

Other end points:

  *Download http://files.vagrantup.com/precise64.box
  *Download https://dl.dropboxusercontent.com/u/547671/thinkstack-raring64.box

* Add boxes:

[\*NIX]


```
$ vagrant box add precise64 <path_to>/precise64.box
$ vagrant box add raring64 <path_to>/thinkstack-raring64.box
```


[Windows + cygwin]

```
$ cd /cygdrive/<letter>/<path_to>/
$ vagrant box add precise64 precise64.box
$ cd /cygdrive/<letter>/<path_to>/
$ vagrant box add raring64 thinkstack-raring64.box
```


[Common]

* Download this project:

 ```
$ git clone https://github.com/icalvete/vagrantfiles.git 
 ```


* Download common manifest

 ```
$ cd  vagrantfiles
$ cd puppet/modules_sp
$ git clone https://github.com/smartpurposes/puppet-modules.git .
$ git submodule init
$ git submodule update
 ```

* Download any manifest you need

 ```
$ cd ..
$ cd puppet/modules
$ git clone  https://< what ever you need >.git
 ```

## Using it:

* Run any service box  (kyototycoon for example)


 ```
$ cd  vagrantfiles/kyototycoon
$ vagrant up
 ```

* Connecting to service box

 ```
$ vagrant ssh
 ```

##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
