name "chef_server"
description "The Provisioning  server"

default_attributes   "chef_server"  => {
    "url" =>  "http://localhost.localdomain:4000",
    "webui_enabled" =>  true
}

run_list(
 [
  "recipe[chef-server::rubygems-install]",
  "recipe[chef-server::nginx-proxy]"
 ]
)


