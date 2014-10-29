require 'bundler/capistrano'
require 'capistrano_colors'
require 'rvm/capistrano'
require 'capistrano-unicorn'
require 'dump/capistrano'

# require 'sidekiq/capistrano'

set :default_stage, 'production'
set :stages, %w(production)

require 'capistrano/ext/multistage' rescue 'YOU NEED TO INSTALL THE capistrano-ext GEM'

# set :whenever_environment, defer { stage }
# set :whenever_identifier, defer { "#{application}_#{stage}" }

# require 'whenever/capistrano'

# set :whenever_command, 'bundle exec whenever'

set :scm, :git
set :scm_verbose, true

set :application, 'blog'
set :repository,  'git@gitlab.welldevtime.ru:cifronomika-ru/knowledge.git'
set :deploy_via, :remote_cache
set :branch, :master

ssh_options[:forward_agent] = true
set :use_sudo, false
set :group_writable, false

set :shared_children, shared_children + %w{public/uploads public/images}
set :normalize_asset_timestamps, false

namespace :deploy do
  task :update_version, :except => { :no_release => true } do
    deploy_time = Time.now.strftime('%d.%m.%Y at %H:%M:%S')
    version = defined?(current_revision) ? "#{branch}-#{current_revision} (#{deploy_time})" : "#{branch} (#{deploy_time})"
    version_code = "#{version}"
    p "Update version to '#{version}'"
    run "echo '#{version_code}' > #{release_path}/public/version.html"
  end

  desc 'Copy the database config file from shared directory to current release directory.'
  task :copy_configs do
    commands = %w(database.yml).map {|config_file| "cp #{shared_path}/config/#{config_file} #{release_path}/config/#{config_file}" }
    run commands.join(' && ')
  end

  desc 'Copy the database config file from shared directory to current release directory.'
  task :copy_app_configs, :roles => :app do
    run "cp #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn/#{rails_env}.rb"
  end

  task :restart, :except => { :no_release => true } do
    unicorn.restart
  end
end

after 'deploy:finalize_update', 'deploy:copy_configs'
after 'deploy:finalize_update', 'deploy:copy_app_configs'
after 'deploy:create_symlink', 'deploy:update_version'