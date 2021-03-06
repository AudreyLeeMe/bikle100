#!/bin/bash

# 
# index.bash

# I use this script to generate a list of a-tags like this:
# Week: 2011-02-20 Through 2011-02-25

# The a-tags will land in this file:
# /pt/s/rl/bikle100/app/views/predictions/_us_stk_past_spool.html.erb
# which is a partial in this file:
# /pt/s/rl/bikle100/app/views/predictions/us_stk_past.haml

# Each a-tag will take me to a set of reports for a specific week.
# The reports will show:
# - Action (buy or sell) summaries
# - tkr summaries
# - Details of all predictions

# Here is some haml which serves as a demo of what I want an a-tag to look like:
# %a(href="/predictions/us_stk_past_wk2011_02_20")
#   Week: 2011-02-20 Through 2011-02-25

# I use us_stk_past.sql to get the data via a join of 3 types of tables:
# prices,gains
# gatt-scores
# gattn-scores

# I use jruby to give me access to Hpricot:
. /pt/s/rluck/svmspy/.jruby

set -x

cd /pt/s/rl/bikle100/app/cj/predictions/us_stk_past/

# Get the data spooled into tmp.html via a join of 3 types of tables.
sqt>us_stk_past.txt<<EOF
@us_stk_past.sql
EOF
grep -v 'rows selected' _us_stk_past_spool.html.erb > tmp.html

# Use Hpricot to massage the HTML in tmp.html and redirect it into the partial full of a-tags:
## jruby --debug index.rb
jruby index.rb > /pt/s/rl/bikle100/app/views/predictions/_us_stk_past_spool.html.erb

# Fill each of the partials with data.
# Start by pulling some syntax out of us_stk_past_week.txt
# which was created by my call to us_stk_past.sql
grep us_stk_past_week.sql us_stk_past_week.txt |awk '{print $1,$2}'> run_us_stk_past_week.sql

sqt>run_us_stk_past_week.txt<<EOF
@run_us_stk_past_week.sql
EOF

# Use ruby to loop through each file created by run_us_stk_past_week.sql
jruby run_us_stk_past_week.rb

exit 0
