name "chef_server"
description "The Provisioning  server"

default_attributes   "chef_server"  => {
  "url" =>  "http://192.168.56.52:4000",
  "webui_enabled" =>  true,
  'ssl_req'  => "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/CN=chef-server-proxy/emailAddress=root@localhost"
}



run_list(
 [
  "recipe[chef-server::rubygems-install]",
  "recipe[chef-server::nginx-proxy]"
 ]
)


