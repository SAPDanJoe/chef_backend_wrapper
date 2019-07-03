name 'chef_backend_wrapper'
maintainer 'Steve Brown'
maintainer_email 'sbrown@chef.io'
license 'Apache-2.0'
description 'Installs/Configures a chef backend'
long_description 'Installs/Configures a chef backend'
version '0.1.4'
chef_version '>= 13.0'
depends 'chef-ingredient'

%w(redhat centos debian ubuntu suse).each do |os|
  supports os
end

issues_url 'https://github.com/devoptimist/chef_backend_wrapper/issues'
source_url 'https://github.com/devoptimist/chef_backend_wrapper'
