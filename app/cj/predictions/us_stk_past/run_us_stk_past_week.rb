#
# run_us_stk_past_week.rb
#

# I use this script to loop through spool files created by sqlplus:
# us_stk_past_week.sql

require 'rubygems'
require 'hpricot'
# require 'ruby-debug'

# I start by getting a list of spool files created by sqlplus (us_stk_past_week.sql):
glb = Dir.glob("/pt/s/rl/bikle100/app/cj/predictions/us_stk_past/tmp_us_stk_past_week_20*.lst").sort

glb.each{|fn|
  # For each file, make note of the date embedded in the filename.
  # The date should be a Sunday.
  # I use the date to identify a weeks worth of data:
  the_date=fn.sub(/tmp_us_stk_past_week_/,'').sub(/.lst/,'').gsub(/-/,'_').sub(/\/.*\//,'')

  # Next, I feed the file to Hpricot so I can access HTML in the file:
  doc = open(fn){ |f| Hpricot(f) }

  # Load some html into a string:
  some_html=doc.search("table.table_us_stk_past_week").to_html

  # I want a file for this URL pattern:
  # href="/predictions/us_stk_past_wk2011_01_30"
  html_f=File.new("/pt/s/rl/bikle100/app/views/predictions/us_stk_past_wk#{the_date}.html.erb", "w")
  # Fill the file with HTML which I had obtained from sqlplus:
  html_f.puts some_html
  p "#{html_f.path} File written"
  html_f.close
}
