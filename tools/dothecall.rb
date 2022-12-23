#!/usr/bin/env ruby

puts File.readlines('squares').map{|line| $~.captures if line =~ /^(\S+)\t(.+) The (.+)$/ }.compact.filter{|lvl, a, b| a.count(?() == a.count(?))}.map{|x|x.inspect}
