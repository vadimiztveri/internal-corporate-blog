puts "\n\e[0;31m   ######################################################################"
puts "   #       Are you REALLY sure you want to deploy to production?        #"
puts "   #               Enter y/n + enter to continue                        #"
puts "   ######################################################################\e[0m\n"
proceed = STDIN.gets[0..0] rescue nil
exit unless proceed.downcase == 'y'

require 'rvm/capistrano'

set :user, :www
set :rvm_type, :user
set :rvm_ruby_string, 'ruby-2.0.0-p353'

set :rails_env, 'production'

set :deploy_to, '/srv/www/blog.cifronomika.ru/production'
set :branch, 'master'
set :hostname, 'http://blog.cifronomika.ru'

server 'blog.cifronomika.ru', :app, :web
role :db, 'blog.cifronomika.ru', :primary => true

# set :sidekiq_role, :sidekiq
# role :sidekiq, 'transformers-upgrade.welldevtime.ru'