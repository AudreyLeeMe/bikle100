# index.rb

require 'rubygems'
require 'hpricot'
# require 'ruby-debug'

doc = open("tmp.html") { |f| Hpricot(f) }

# debugger

# p doc.class

td_elems = doc.search("td")

# Insert links inside each td-element:
td_elems.each{|td|
  # Change Week: 2011-01-31 Through 2011-02-04
  # to
  # /predictions/fx_past_wk2011_01_31
  hhref=td.innerHTML.sub(/Week: /,'').sub(/ Through .*$/,'')
  hhref=td.innerHTML.gsub(/\n/,'').sub(/Week: /,'').sub(/ Through .*$/,'')
  hhref=td.innerHTML.gsub(/\n/,'').sub(/Week: /,'').sub(/ Through .*$/,'').gsub(/-/,'_')
  hhref="/predictions/fx_past_wk#{hhref}"
  td.innerHTML="<a href='#{hhref}'>#{td.innerHTML.gsub(/\n/,'')}</a>"
}

# I dont need the th-element (or its parent):
doc.search("table#table_fx_past th/..").remove

# Im done, print it now so my shell can redirect the HTML into a file:
print doc.search("table#table_fx_past").to_html
