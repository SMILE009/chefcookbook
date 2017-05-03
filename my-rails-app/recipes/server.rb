include_recipe "yum-epel"
include_recipe "git"

# OS Dependencies
%w(ntp zlib-devel nodejs ImageMagick openssl-devel).each do |pkg|
  package pkg
end

include_recipe "postgresql::ruby"
include_recipe "postgresql::server"

# getting cookbook attributes
#mra_deploy_user = node['my-rails-app']['deploy_user']
mra_deploy_user = node['my-rails-app']['app_user']
mra_app_user = node['my-rails-app']['app_user']
mra_app_name = node['my-rails-app']['app_name']
mra_app_database = node['my-rails-app']['app_database']

# prividing application database attributes
node.override['my-rails-app']['databases']['postgresql'] = [
  {
    "database_name" => mra_app_database,
    "username" => mra_deploy_user,
    "password" => mra_deploy_user,
    "owner" => mra_deploy_user,
    "privileges" => [:all]
  }
]

# we create new user that will run our application server
user_account mra_deploy_user do
  create_group true
  ssh_keygen false
end

postgresql_connection_info = {
  :host => "localhost",
  :port => node['postgresql']['config']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

node['my-rails-app']['databases']['postgresql'].each do |entry|
  postgresql_database_user entry['username'] do
    connection postgresql_connection_info
    action [:create]
    password(entry['password'])           if entry['password']
  end

  postgresql_database entry['database_name'] do
    connection postgresql_connection_info
    template entry['template'] if entry['template']
    encoding entry['encoding'] if entry['encoding']
    collation entry['collation'] if entry['collation']
    connection_limit entry['connection_limit'] if entry['connection_limit']
    owner entry['owner'] if entry['owner']
    action :create
  end

  postgresql_database_user entry['username'] do
    connection postgresql_connection_info
    action [:grant]
    database_name(entry['database_name']) if entry['database_name']
    privileges(entry['privileges'])       if entry['privileges']
    createdb true
  end
end

ENV['RACK_ENV'] = 'production'
ENV['RAILS_ENV'] = 'production'
ENV['LANGUAGE_SCHOOL_DATABASE_PASSWORD'] = mra_deploy_user
application "/home/#{mra_deploy_user}/#{mra_app_name}" do
  ruby '2.3'
#  owner mra_deploy_user
#  group mra_deploy_user
#  user mra_deploy_user
  git "/home/#{mra_deploy_user}/#{mra_app_name}" do
#  git '/home/deployer/langschool' do
    action [:sync]
    repository "https://github.com/dhotcolorado/lang-school-github.git"
    revision "HEAD"
    remote "origin"
  end

  bundle_install do
    deployment true
    without %w{development test}
  end

  rails do
    database "postgresql://#{mra_deploy_user}@localhost/#{mra_app_database}" do
      password mra_deploy_user
    end
    migrate true
  end

  ruby_execute 'rake db:seed'

  puma do
    port 8000
  end
end

log "Language School is finally up and running!"