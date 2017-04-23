#
# Cookbook Name:: nrpe
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nrpe'
package 'nagios-plugins'
package 'nagios-plugins-users'
package 'nagios-plugins-tcp'
package 'nagios-plugins-log'
package 'nagios-plugins-uptime'
package 'nagios-plugins-load'
package 'nagios-plugins-swap'
package 'nagios-plugins-disk'
package 'nagios-plugins-procs'


#Need to modify, create some permissions to directory nagios if not exist to DEMO2 ))
directory '/etc/nagios/'


template '/etc/nagios/nrpe.conf' do
	source 'client.conf.erb'
end

service 'nrpe' do
	action [:enable, :start]
end
