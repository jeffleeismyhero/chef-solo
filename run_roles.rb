#!/usr/bin/env ruby
require 'chef/application/solo'
require 'chef/data_bag_item'
require 'json'
require 'pty'

current_path = File.expand_path(File.dirname( __FILE__))

Chef::Config[:solo] = true
Chef::Config[:data_bag_path] = "#{current_path}/data_bags"
current_host = ARGV[0].gsub(/\./,'_')

exit unless current_host

begin
  node = Chef::DataBagItem.load(:node, current_host)
  roles =  node["role"]
rescue
  puts "Databag configuration for host #{ARGV[0]} not found"
  exit
end

# TODO: Currently only run_list's merged, make it handle all JSON
# atributes.
run_lists = []
roles.map{ |x| "#{ current_path}/#{x}.json"}.each do |role|
  run_lists += JSON.parse(File.read role)["run_list"] if File.exists? role
end

File.open("#{current_path}/#{current_host}.json", "w") do |f|
  f.print({
            run_list: run_lists.compact.uniq, # Run list for the host
            net: {   # Generate networking infor for hostname cookbook
              hostname: node["hostname"] ,
              FQDN:     node["fqdn"],
              IP:       node["ipaddress"]
            }
          }.to_json)
end

cmd = "cd #{current_path} && chef-solo --config solo.rb --json-attributes #{current_host}.json"
begin
  PTY.spawn (cmd) do |stdin, stout, pid|
    begin
      stdin.each { |line| print line }
    rescue Errno::EIO
    end
  end
rescue PTY::ChildExited
  puts "The child process exited!"
end
