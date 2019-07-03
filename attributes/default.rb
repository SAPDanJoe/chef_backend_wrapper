default['chef_backend_wrapper']['channel'] = :stable
default['chef_backend_wrapper']['version'] = '2.0.30'
default['chef_backend_wrapper']['accept_license'] = true
default['chef_backend_wrapper']['config'] = ''
default['chef_backend_wrapper']['peers'] = ''
default['chef_backend_wrapper']['fqdn'] = ''

default['chef_backend_wrapper']['frontend_fqdns'] = []
default['chef_backend_wrapper']['frontend_config_dir'] = '/root/fe_config'

default['chef_backend_wrapper']['frontend_config_details'] =
  "#{node['chef_backend_wrapper']['frontend_config_dir']}/fe_details.json"

default['chef_backend_wrapper']['frontend_parser_script'] = '/bin/fe_parse.rb'

default['chef_backend_wrapper']['backend_secrets'] = ''
default['chef_backend_wrapper']['jq_url'] = 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'

default['chef_backend_wrapper']['cloud_public_address'] = false

default['chef_backend_wrapper']['sles_patch_file_name'] = '_save_current_run.rb'
default['chef_backend_wrapper']['sles_patch_file_path'] =
  "/opt/chef-backend/embedded/cookbooks/chef-backend/recipes/#{node['chef_backend_wrapper']['sles_patch_file_name']}"
