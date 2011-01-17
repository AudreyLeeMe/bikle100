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

Here is info about the git repo:

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
[remote "heroku"]
	url = git@heroku.com:bikle100.git
	fetch = +refs/heads/*:refs/remotes/heroku/*



oracle@z2:/pt/s/rl/bikle100$ gst
# On branch master
nothing to commit (working directory clean)
oracle@z2:/pt/s/rl/bikle100$ gphm
The authenticity of host 'heroku.com (75.101.163.44)' can't be established.
RSA key fingerprint is 8b:48:5e:67:0e:c9:16:47:32:f2:87:0c:1f:c8:60:ad.
Are you sure you want to continue connecting (yes/no)? yes

Warning: Permanently added 'heroku.com,75.101.163.44' (RSA) to the list of known hosts.
Counting objects: 7, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 1.45 KiB, done.
Total 6 (delta 3), reused 0 (delta 0)

-----> Heroku receiving push
-----> Rails app detected
-----> Detected Rails is not set to serve static_assets
       Installing rails3_serve_static_assets... done
-----> Gemfile detected, running Bundler version 1.0.3
       All dependencies are satisfied
       Compiled slug size is 3.9MB
-----> Launching... done
       http://bikle100.heroku.com deployed to Heroku

To git@heroku.com:bikle100.git
   f561759..55fa785  master -> master
oracle@z2:/pt/s/rl/bikle100$ 

