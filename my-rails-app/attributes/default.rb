#

default['my-rails-app']['app_name'] = 'language-school'
default['my-rails-app']['deploy_user'] = 'deployer'
default['my-rails-app']['app_user'] = "#{node['my-rails-app']['app_name']}"

# Establish default database name
default['my-rails-app']['app_database'] = "#{node['my-rails-app']['app_name']}_production"

default['my-rails-app']['databases']['postgresql'] = []