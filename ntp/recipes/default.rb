#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package 'ntp'

service 'ntpd' do
	action [:enable, :start]
end

execute 'Change TimeZone' do
	command 'timedatectl set-timezone Europe/Kiev'
	action :run
end
 
