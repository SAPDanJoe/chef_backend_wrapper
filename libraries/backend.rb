#
# Chef Documentation
# https://docs.chef.io/libraries.html
#

#
# This module name was auto-generated from the cookbook name. This name is a
# single word that starts with a capital letter and then continues to use
# camel-casing throughout the remainder of the name.
#
module ChefBackendWrapper
  module BackendHelpers
    def update_configs?(fe_details, fe_nodes)
      if fe_nodes >= 1
        if ::File.file?(fe_details)
          base = ::File.dirname(fe_details)
          (Dir.glob("#{base}/*chef-server.rb")
            .map { |i| i.gsub(%r{#{base}/}, '') } - JSON.parse(File.read(fe_details))
            .keys.map { |i| "#{i}-chef-server.rb" }).length >= 1
        else
          true
        end
      else
        false
      end
    end
  end
end
