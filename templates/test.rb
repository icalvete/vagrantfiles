#!/usr/bin/ruby

require 'erb'


  name = 'isra'
  
  template = File.open('Vagrantfile.erb', 'r').read
  erb = ERB.new(template)
  File.open('Vagrantfile', 'w+') { |file| file.write(erb.result(binding)) }


