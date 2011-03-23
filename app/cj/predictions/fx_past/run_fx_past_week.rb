#
# run_fx_past_week.rb
#

# I use this script to loop through .lst files created by sqlplus.

require 'rubygems'
require 'hpricot'
require 'ruby-debug'

glb = Dir.glob("/pt/s/rl/bikle100/app/cj/predictions/fx_past/tmp_fx_past_week_20*.lst").sort
debugger
p glb
