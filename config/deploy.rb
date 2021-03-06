# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "sentiment-analysis"
set :deploy_user, 'deployer'
set :repo_url, "git@github.com:nascenia/sentiment-rails.git"
set :ssh_options, forward_agent: true
set :pty, true
set :deploy_via, :remote_cache
set :deploy_path, '/apps'
set :use_sudo, true

set :rbenv_type, :system
set :rbenv_ruby, '2.4.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]

set :keep_releases, 5

set :bundle_binstubs, nil

set :linked_files, %w[config/database.yml config/secrets.yml config/cable.yml config/puma.rb .env]

set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads]

set(:config_files, %w(
  nginx.conf
  database.example.yml
  application.example.yml
  log_rotation
  puma.rb
  puma_init.sh
))

set(:executable_config_files, %w[puma_init.sh])

set(
    :symlinks,
    [
        {
            source: 'nginx.conf',
            link: '/etc/nginx/sites-enabled/{{full_app_name}}.conf'
        },
        {
            source: 'puma_init.sh',
            link: '/etc/init.d/puma_{{full_app_name}}'
        },
        {
            source: 'log_rotation',
            link: '/etc/logrotate.d/{{full_app_name}}'
        }
    ]
)

namespace :deploy do
  before :deploy, 'deploy:check_revision'
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  before 'deploy:setup_config', 'nginx:remove_default_vhost'
  after 'deploy:setup_config', 'nginx:reload'
  after 'deploy:publishing', 'deploy:restart'
end
