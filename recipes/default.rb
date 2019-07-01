#
# Cookbook:: chef_backend_wrapper
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

user 'chef_pgsql'
group 'chef_pgsql'

remote_file '/bin/jq' do
  source node['chef_backend_wrapper']['jq_url']
  mode '0755'
end

config = node['chef_backend_wrapper']['config']
config += <<~EOF
          EOF

hostname = if node['chef_backend_wrapper']['fqdn'] != ''
             node['chef_backend_wrapper']['fqdn']
           elsif node['cloud']
             node['cloud']['public_ipv4_addrs'].first
           else
             node['ipaddress']
           end

secrets = if node['chef_backend_wrapper']['backend_secrets'] != ''
            node['chef_backend_wrapper']['backend_secrets']
          else
            'cookbook_file://chef_backend_wrapper::chef-backend-secrets.json'
          end

chef_backend 'chef-backend' do
  channel node['chef_backend_wrapper']['channel'].to_sym
  chef_backend_secrets secrets
  config config
  publish_address hostname
  action :create
  peers node['chef_backend_wrapper']['peers']
  version node['chef_backend_wrapper']['version']
  accept_license node['chef_backend_wrapper']['accept_license'].to_s == 'true' ? true : false
end

directory node['chef_backend_wrapper']['frontend_config_dir']

node['chef_backend_wrapper']['frontend_fqdns'].each do |fe|
  execute "chef-backend-ctl gen-server-config #{fe} -f #{fe}-chef-server.rb" do
    cwd node['chef_backend_wrapper']['frontend_config_dir'] 
    not_if { ::File.file?("#{node['chef_backend_wrapper']['frontend_config_dir']}/#{fe}-chef-server.rb") }
  end
end

cookbook_file node['chef_backend_wrapper']['frontend_parser_script'] do
  source 'fe_parse.rb'
  only_if { node['chef_backend_wrapper']['frontend_fqdns'].length >= 1 }
end

execute '/opt/chef-backend/embedded/bin/ruby /bin/fe_parse.rb' do
  cwd node['chef_backend_wrapper']['frontend_config_dir']
  only_if { ::File.file?(node['chef_backend_wrapper']['frontend_parser_script']) }
  not_if { ::File.file?(node['chef_backend_wrapper']['frontend_config_details']) }
end
