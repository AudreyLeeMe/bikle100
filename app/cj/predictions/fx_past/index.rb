# index.rb

require 'rubygems'
require 'hpricot'

doc = open("tmp.html") { |f| Hpricot(f) }

p doc.class

