lock '3.4.1'

set :application, 'vigilance'

# Server
set :deploy_to, '~/www'
#set :linked_files, %w{config/secrets.yml}

# Git
set :repo_url, 'git@github.com:alexandre025/vigilance.git'
set :user, 'alexandre'
set :branch, :master

# Ruby
set :rbenv_type, :system
set :rbenv_ruby, '2.3.0'
set :rbenv_custom_path, '/home/alexandre/.rbenv'

namespace :deploy do

  desc 'Reload server'
  task :refresh_server do

    on roles(:app) do
      within release_path do
        execute :bundle, :install
        execute :rails, 'db:create'
        execute :rails, 'db:migrate'
        execute :rails, 'assets:precompile'
        execute :rails, 'tmp:cache:clear'
        execute :rails, 's -e production -d -b localhost'
      end
    end
  end

end

after :deploy, 'deploy:refresh_server'
