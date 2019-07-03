# Author:: Marc Paradise <marc@chef.io>
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
#
# All Rights Reserved

file "/etc/chef-backend/chef-backend-running.json" do
  owner BackendHelper.new(node).username
  group BackendHelper.new(node).groupname('leaderl')
  mode "0640"

  if node['runit'].nil?
    node.default['runit'] = {}
  end

  file_content = {
    "chef-backend" => node['chef-backend'].to_hash,
    # Required in order to use offline tools that need ip address data.
    "run_list" => node.run_list,
    "runit" => node['runit'].to_hash,
  }
  content Chef::JSONCompat.to_json_pretty(file_content)
end
