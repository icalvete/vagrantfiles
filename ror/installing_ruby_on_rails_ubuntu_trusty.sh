#!/bin/bash

# For https://www.coursera.org/learn/ruby-on-rails-intro/home/welcome
#
# Based on https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04

sudo  apt-get update -y

sudo apt-get --ignore-missing install \
build-essential \
git \
git-core \
curl \
openssl \
libssl-dev \
libcurl4-openssl-dev \
zlib1g \
zlib1g-dev \
libreadline-dev \
libreadline6 \
libreadline6-dev \
libyaml-dev \
libsqlite3-dev \
libsqlite3-0 \
sqlite3 \
libxml2-dev \
libxslt1-dev \
python-software-properties \
libffi-dev \
libgdm-dev \
libncurses5-dev \
libmysqlclient-dev \
automake \
autoconf \
libtool \
bison \
libc6-dev \
nodejs \
bzip2 \
vim \
software-properties-common \
python-software-properties \
-y

sudo add-apt-repository ppa:chris-lea/node.js -y
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

echo "gem: --no-document" > ~/.gemrc

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

. ~/.bashrc

${HOME}/.rbenv/bin/rbenv install -v 2.2.3
${HOME}/.rbenv/bin/rbenv global 2.2.3

${HOME}/.rbenv/shims/gem install bundler
# 4.2.3 version for Coursera course
${HOME}/.rbenv/shims/gem install rails -v 4.2.3
${HOME}/.rbenv/bin/rbenv rehash

export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
cd /tmp
curl -L https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 | tar xvjf -
sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
