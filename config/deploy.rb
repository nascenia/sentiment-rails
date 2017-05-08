# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "sentiment-analysis"
set :repo_url, "https://github.com/awladnas/sentiment-rails.git"

# default_run_options[:pty] = true

# set :scm, :git
set :deploy_via, :remote_cache
set :branch, "master"
set :keep_releases, 5

set :deploy_to, "/www/apps/#{fetch(:application)}/"

set :user, "deployer"
set :use_sudo, false
set :rvm_ruby_string, 'ruby-2.3.1'
set :rvm_type, :system
set :rake, 'bundle exec rake'

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
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
