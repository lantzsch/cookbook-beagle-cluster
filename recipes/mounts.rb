#
# Cookbook:: cookbook-beagle-cluster
# Recipe:: mounts
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'mountall' do
  command '/sbin/mountall'
  action :nothing
end

node['beagle']['mounts'].each do |mount_point, mount_data|
  directory mount_point do
    recursive true
  end

  mount mount_point do
    device mount_data['device']
    fstype mount_data['fstype']
    options mount_data['options']
    action :enable
    notifies :run, 'execute[mountall]', :delayed
  end
end
