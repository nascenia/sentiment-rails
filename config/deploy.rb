# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "sentiment-analysis"
set :repo_url, "https://github.com/awladnas/sentiment-rails.git"

# default_run_options[:pty] = true

# set :scm, :git
set :deploy_via, :remote_cache
set :branch, "master"
set :keep_releases, 25

set :deploy_to, "/www/apps/#{fetch(:application)}/"

set :user, "deployer"
set :use_sudo, true
set :rvm_ruby_version, '2.4.0'

# set :rvm_path, "/usr/local/rvm"
# set :bundle_cmd, "bundle"
# set :rvm_type, :system
# set :rake, 'bundle exec rake'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/cable.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
# set :passenger_restart_with_touch, true

namespace :deploy do
  task :run_servers do
    # with_options current_path do
    on roles(:web) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute "redis-server --daemonize yes"
          # execute "cd #{fetch(:deploy_to)}current"
          execute "RAILS_ENV=production passenger stop  --port 4000"
          execute "RAILS_ENV=production passenger start  --port 4000 -d"
        end
      end
    end
    # end
  end
  after :finished, 'deploy:run_servers'
end
