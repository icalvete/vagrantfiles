#!/usr/bin/ruby

require 'erb'
name = "Rasmus"
template_string = "My name is <%= name %>"
template = ERB.new template_string
puts template.result # prints "My name is Rasmus"
