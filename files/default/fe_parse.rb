require 'json'

hash = {}

Dir.glob("*-chef-server.rb").each do |f|
  hash[f.gsub('-chef-server.rb','')] = ::File.read(f)
end

::File.write('fe_details.json', hash.to_json)
