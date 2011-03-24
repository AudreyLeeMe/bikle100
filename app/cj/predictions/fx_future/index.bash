#!/bin/bash

# index.bash

# I use this script to help me see Forex future predictions.

# I use jruby to give me access to Hpricot:
. /pt/s/rluck/svm62/.jruby

set -x

cd /pt/s/rl/bikle100/app/cj/predictions/fx_future/

# Get the data spooled into tmp.html
sqt>>fx_future.txt<<EOF
@fx_future.sql
EOF
grep -v 'rows selected' _fx_future_spool.html.erb > tmp.html

# Use Hpricot to massage the HTML in tmp.html and redirect it into a "partial":
# jruby --debug index.rb > /pt/s/rl/bikle100/app/views/predictions/_fx_future_spool.html.erb
jruby index.rb > /pt/s/rl/bikle100/app/views/predictions/_fx_future_spool.html.erb

exit 0
