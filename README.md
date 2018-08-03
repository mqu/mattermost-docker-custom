# mattermost-docker-custom
a customized version for Mattermost dockerized container.

this repository contains an alternative to official mattermost dockerized environment. This one allow to customize some features. By default :

* mariadb is used,
* auto import SQL at startup


## usage

	git clone https://github.com/mqu/mattermost-docker-custom.git
	cd mattermost-docker-custom

	# will set uid/gid in shared volumes according to local user (for mattermost container)
	export UID=$(id -i)
	export GID=$(id -g)

	mkdir -p ./volumes/app/mattermost/{data,logs,config}

	# importing data from an existing mattermost instance :
	cp $src/mattermost-sql-dump.sql volumes/srv/mattermost.sql[.bzip2]
	cp -rp $src/data volumes/app/mattermost/

	# overriding defaults values :
	# rename docker-compose-override.yml.tmpl to docker-compose-override.yml and change values as needed
	# you may add your scripts in app/override/XXX-enabled*.sh
	# you can disable any-script in app/override/XXX-enabled*.sh (rm or rename them)

	docker-compose build
	docker-compose up

## links

* https://github.com/mattermost/mattermost-docker
* https://hub.docker.com/r/mattermost/mattermost-prod-app/
* https://github.com/mqu/mattermost-docker-custom
