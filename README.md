# Zabbix-Utils
Collection of scripts to help manage Zabbix

## Zabbix User Migrator script usage
Dependencies: https://github.com/express42/zabbixapi

Use cases: When in need to migrate users from one zabbix instance to another

To do ideas: bringing in the functionality for syncer rather than migrator, so with one script you could keep your two different zabbix installations in sync (user wise!)

Usage:
`ruby zabbix-user-migrator.rb`

## Zabbix Agent Easyinstall
Dependencies: lsb-release package

Use cases: If you want to bootstrap nodes quickly without having the means of any configuration management tools such as chef or salt

Usage: create the file in your node

`chmod +x zabbix-agent-easyinstall.sh`

`sh zabbix-agent-easyinstall.sh`
