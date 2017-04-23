#
# Cookbook Name:: nagios-server-config
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


search(:node, "roles:test") do |node|
	puts 
	template '/etc/nagios/conf.d/123.conf' do
		source 'host.config.erb'
	end
end

service 'nagios' do
	action [:restart]
end
