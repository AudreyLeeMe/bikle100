#!/bin/bash

# index.bash

# I use this script to generate a list of a-tags like this:
# Week: 2011-02-20 Through 2011-02-25 
# Each a-tag will take me to a set of reports for a specific week.
# The reports will show:
# - Action (buy or sell) summaries
# - pair summaries
# - Details of all predictions

# Here is some haml which serves as a demo of what I want an a-tag to look like:
# %a(href="/predictions/fx_past_wk2011_02_20")
#   Week: 2011-02-20 Through 2011-02-25

# The data will come from a join of 3 types of tables:
# prices,gains
# gatt-scores
# gattn-scores

. /pt/s/rluck/svm62/.jruby

set -x

cd /pt/s/rl/bikle100/app/cj/predictions/fx_past/

sqt>>fx_past.txt<<EOF
@fx_past.sql
EOF

grep -v 'rows selected' _fx_past_spool.html.erb | sed '1,$s/WWEEK//' > tmp.html

jruby index.rb > /pt/s/rl/bikle100/app/views/predictions/_fx_past_spool.html.erb

exit 0

