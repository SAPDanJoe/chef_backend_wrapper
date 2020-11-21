# InSpec test for recipe chef_backend_wrapper::default

# The InSpec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(9200) do
  it { should be_listening }
end

describe port(9300) do
  it { should be_listening }
end

describe port(5432) do
  it { should be_listening }
end

describe port(7331) do
  it { should be_listening }
end

describe command('hostname -s') do
  its('exit_status') { should eq 0 }
end

parse_files = %w(
  /root/fe_config/fe_details.json
  /bin/fe_parse.rb
)

config_files = %w(
  3.8.148.155-chef-server.rb
  3.8.148.156-chef-server.rb
  3.8.148.157-chef-server.rb
  3.8.148.158-chef-server.rb
  3.8.148.159-chef-server.rb
  3.8.148.160-chef-server.rb
)

ip = JSON.parse(command('ohai').stdout)['ipaddress']

config_files.each do |f|
  fqdn = f.gsub('-chef-server.rb', '')
  describe file("/root/fe_config/#{f}") do
    its('content') { should match(/fqdn "#{fqdn}"/) }
    its('content') { should match(/chef_backend_members \["#{ip}"\]/) }
  end
end

parse_files.each do |f|
  describe file(f) do
    it { should exist }
  end
end
