#
# index.rb
#

# I use this script to massage the contents of tmp.html after it is created by sqlplus.

require 'rubygems'
require 'hpricot'
# require 'ruby-debug'

doc = open("tmp.html") { |f| Hpricot(f) }

# debugger

# p doc.class

# Im done, print it now so my shell can redirect the HTML into a file:
print doc.search("table#table_fx_future").to_html
