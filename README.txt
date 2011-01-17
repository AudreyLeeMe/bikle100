I have this setup on my Linux box:


oracle@z2:/pt/s/rl/bikle100$ which ruby
/home/oracle/.rvm/bin/ruby
oracle@z2:/pt/s/rl/bikle100$ ruby -v
ruby 1.9.2p14 (2010-10-02 revision 29393) [x86_64-linux]
oracle@z2:/pt/s/rl/bikle100$ gem list

*** LOCAL GEMS ***

abstract (1.0.0)
actionmailer (3.0.1)
actionpack (3.0.1)
activemodel (3.0.1)
activerecord (3.0.1)
activeresource (3.0.1)
activesupport (3.0.1)
arel (1.0.1)
builder (2.1.2)
bundler (1.0.3)
configuration (1.1.0)
erubis (2.6.6)
haml (3.0.22)
heroku (1.11.0)
i18n (0.4.2)
json_pure (1.4.6)
launchy (0.3.7)
mail (2.2.9)
mime-types (1.16)
polyglot (0.3.1)
rack (1.2.1)
rack-mount (0.6.13)
rack-test (0.5.6)
rails (3.0.1)
railties (3.0.1)
rake (0.8.7)
rest-client (1.6.1)
sqlite3-ruby (1.3.2)
thor (0.14.3)
treetop (1.4.8)
tzinfo (0.3.23)
oracle@z2:/pt/s/rl/bikle100$ 
oracle@z2:/pt/s/rl/bikle100$ ll script/
total 12
drwxr-xr-x  2 oracle oinstall 4096 2010-10-31 01:45 ./
drwxr-xr-x 15 oracle oinstall 4096 2010-10-31 01:09 ../
-rwxr-xr-x  1 oracle oinstall  295 2010-10-31 01:45 rails*
oracle@z2:/pt/s/rl/bikle100$ 
oracle@z2:/pt/s/rl/bikle100$ 
oracle@z2:/pt/s/rl/bikle100$ script/rails server
=> Booting WEBrick
=> Rails 3.0.1 application starting in development on http://0.0.0.0:3000
=> Call with -d to detach
=> Ctrl-C to shutdown server
[2011-01-17 02:48:13] INFO  WEBrick 1.3.1
[2011-01-17 02:48:13] INFO  ruby 1.9.2 (2010-10-02) [x86_64-linux]
[2011-01-17 02:48:13] INFO  WEBrick::HTTPServer#start: pid=20127 port=3000


Started GET "/r10/about" for 127.0.0.1 at 2011-01-17 02:51:52 +0000
  Processing by R10Controller#about as HTML
Rendered r10/about.haml within layouts/application (64.5ms)
Completed 200 OK in 114ms (Views: 113.7ms | ActiveRecord: 0.0ms)


oracle@z2:/pt/s/rl/bikle100$ 
oracle@z2:/pt/s/rl/bikle100$ 
oracle@z2:/pt/s/rl/bikle100$ rvm gemdir
/home/oracle/.rvm/gems/ruby-1.9.2-head@gs1
oracle@z2:/pt/s/rl/bikle100$ 
oracle@z2:/pt/s/rl/bikle100$ 

