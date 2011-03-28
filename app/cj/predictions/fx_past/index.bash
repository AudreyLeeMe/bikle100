#!/bin/bash

# index.bash

# I use this script to generate a list of a-tags like this:
# Week: 2011-02-20 Through 2011-02-25

# The a-tags will land in this file:
# /pt/s/rl/bikle100/app/views/predictions/_fx_past_spool.html.erb
# which is a partial in this file:
# /pt/s/rl/bikle100/app/views/predictions/fx_past.haml

# Each a-tag will take me to a set of reports for a specific week.
# The reports will show:
# - Action (buy or sell) summaries
# - pair summaries
# - Details of all predictions

# Here is some haml which serves as a demo of what I want an a-tag to look like:
# %a(href="/predictions/fx_past_wk2011_02_20")
#   Week: 2011-02-20 Through 2011-02-25

# I use fx_past.sql to get the data via a join of 3 types of tables:
# prices,gains
# gatt-scores
# gattn-scores

# I use jruby to give me access to Hpricot:
. /pt/s/rluck/svm62/.jruby

set -x

cd /pt/s/rl/bikle100/app/cj/predictions/fx_past/

# Get the data spooled into tmp.html via a join of 3 types of tables.
sqt>fx_past.txt<<EOF
@fx_past.sql
EOF
grep -v 'rows selected' _fx_past_spool.html.erb > tmp.html

# Use Hpricot to massage the HTML in tmp.html and redirect it into the partial full of a-tags:
# jruby --debug index.rb > /pt/s/rl/bikle100/app/views/predictions/_fx_past_spool.html.erb
jruby index.rb > /pt/s/rl/bikle100/app/views/predictions/_fx_past_spool.html.erb

# Fill each of the partials with data.
# Start by pulling some syntax out of fx_past_week.txt
# which was created by my call to fx_past.sql
grep fx_past_week.sql fx_past_week.txt > run_fx_past_week.sql

sqt>>run_fx_past_week.txt<<EOF
@run_fx_past_week.sql
EOF

# Use ruby to loop through each file created by run_fx_past_week.sql
jruby run_fx_past_week.rb


exit 0

