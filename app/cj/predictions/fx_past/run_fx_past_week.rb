#
# run_fx_past_week.rb
#

# I use this script to loop through .lst files created by sqlplus.

require 'rubygems'
require 'hpricot'
require 'ruby-debug'

glb = Dir.glob("/pt/s/rl/bikle100/app/cj/predictions/fx_past/tmp_fx_past_week_20*.lst").sort
# p glb
glb.each{|fn|
  debugger
  the_date=fn.sub(/tmp_fx_past_week_/,'').sub(/.lst/,'').gsub(/-/,'_').sub(/\/.*\//,'')
  doc = open(fn){ |f| Hpricot(f) }
  some_html=doc.search("table.table_fx_past_week").to_html
  # I want a file for this URL pattern:
  # href="/predictions/fx_past_wk2011_01_30"
  html_f=File.new("/pt/s/rl/bikle100/app/views/predictions/fx_past_wk#{the_date}.html.erb", "w")
  html_f.puts some_html
  p "#{html_f.path} File written"
  html_f.close
}
