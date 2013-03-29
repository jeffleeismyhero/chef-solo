name "web_server"
description "Builds a web server for Rails apps"
run_list( 
    "recipe[nginx]",
    "recipe[github_keys]"
    )

default_attributes "github_keys" => {
  "local" => {
    "user" => "ubuntu",
    "identity"=> "id_dsa"
  }
}
