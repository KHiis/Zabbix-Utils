#encoding: UTF-8
require "zabbixapi"
require "json"
require "rubygems"
require "net/https"

# Connect to the Zabbix server you want to import users from
zbx = ZabbixApi.connect(
  :url => 'https://zabbix1-url/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix'
)

# Connect to Zabbix server you want to import users to
zbx2 = ZabbixApi.connect(
  :url => 'https://zabbix2-url/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix'
)

# Query the users from first Zabbix server
usrs = zbx.query(
  :method => 'user.get',
  :params => {}
)

# Remove the users that already exsist from the array 
rem = ['Admin', 'guest', 'any-other-exsisting-user']

# Create new users to second Zabbix server
usrs.each do |stats|
  f = 0
  rem.each do |remove|
    if remove == stats['alias']
      f = 1
    end
  end
  if f == 0
    zbx2.users.create(
    :alias => "#{stats["alias"]}",
    :name => "#{stats["name"]}",
    :surname => "#{stats["surname"]}",
    :passwd => 'password',
    :usrgrps => [
      :usrgrpid => '15' # Change this number to the according user group that you want your new users to be assigned
    ]
  )
  end
end
