# vagrant-ror-box

Creating my own vagrant box 4 Ruby or Ruby on Rails development environment.

# Overview

This box was created using https://github.com/icalvete/vagrant-ror-box

The final box is https://atlas.hashicorp.com/icalvete/boxes/ror/versions/0.0.2

At the end, the box offers...

* [rbenv](https://github.com/sstephenson/rbenv)
* [ruby-build](https://github.com/sstephenson/ruby-build)
* [rbenv-binstubs](https://github.com/ianheggie/rbenv-binstubs)
* [rbenv-gem-rehash](https://github.com/sstephenson/rbenv-gem-rehash)
* [rbenv-update](https://github.com/rkh/rbenv-update)
* [heroku-command-line](https://devcenter.heroku.com/articles/heroku-command-line) (Not in the box. Instaled with puppet during vagrant up)

Ready to easy develop any [Ruby](http://ruby-doc.org/) or [Ruby on Rails](http://rubyonrails.org/) app.

## Custom the box

You could customize whatever you want before export the box

For example, to see a version from [ruby-build built-in definitions](https://github.com/rbenv/ruby-build/tree/master/share/ruby-build)

```bash
 $ ruby-build --definitions
```

To add some version to the box.

```bash
 $ rbenv install -v 1.9.3-p551
```

## Way of working

Then for each application directory run the following just once:

```bash
$ bundle install --path vendor/bundle --binstubs .bundle/bin
```

Since you have **_BUNDLE_PATH: ~/vendor/bundle_** inside your **_~/.bundle/config_** all gem instaled using gem will be instaled in **_~/vendor/bundle_** but ...

Since you have **_BUNDLE_DISABLE_SHARED_GEMS: "1"_** inside your **_~/.bundle/config_** every app is a full isolated gem environment after you run...

```bash
$ bundle install --path vendor/bundle --binstubs .bundle/bin
```

## Authors:

Israel Calvete Talavera <icalvete@gmail.com>
