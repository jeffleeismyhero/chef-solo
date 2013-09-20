#
# Be able to have custom private chef-solo configuration.
#
# 2 variables define location of the chef-solo configuration:
#
# CHEF_SOLO_PROFILE_ROOT - absolute path, if not provided current directory is used
#
# CHEF_SOLO_PROFILE - if name of the profile provided subdirectory
#     under ./profiles/ is used as base.
#  
root = ENV["CHEF_SOLO_PROFILE_ROOT"] || File.absolute_path(File.dirname(__FILE__))
root << "profiles/#{ENV["CHEF_SOLO_PROFILE"]}" if ENV["CHEF_SOLO_PROFILE"]


file_cache_path root
cookbook_path ["#{root}/cookbooks", "#{root}/site-cookbooks"]
role_path     "#{root}/roles"
data_bag_path "#{root}/data_bags"
log_level :info
log_location STDOUT
