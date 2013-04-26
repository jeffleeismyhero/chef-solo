name "Redis"
description "Redis key-value store"

default_attributes :redis => {
  "daemonize" => "yes",
  "pidfile"   => "/var/run/redis/redis-server.pid",
  'config_path'  => "/etc/redis.conf",
  'bind' => '127.0.0.1'
}

run_list ["recipe[redis]"] 




