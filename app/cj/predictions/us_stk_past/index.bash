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
. /pt/s/rluck/svm62/.jruby

set -x

cd /pt/s/rl/bikle100/app/cj/predictions/us_stk_past/

# Get the data spooled into tmp.html via a join of 3 types of tables.
sqt>us_stk_past.txt<<EOF
@us_stk_past.sql
EOF
