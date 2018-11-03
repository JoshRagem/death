CODENAME := $(shell cat /etc/lsb-release | grep CODENAME | cut -d '=' -f 2)
USER := $(shell whoami)

executables := /usr/sbin/openvpn /usr/bin/startx /usr/bin/docker /usr/bin/node /usr/bin/resilio-sync /bin/gunzip
lists := /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/nodesource.list /etc/apt/sources.list.d/resilio-sync.list

setup: $(lists)
	apt update
	apt-get install -y apt-transport-https ca-certificates curl software-properties-common xautolock

/etc/apt/sources.list.d/docker.list:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic edge" > /etc/apt/sources.list.d/docker.list

/etc/apt/sources.list.d/nodesource.list:
	curl -sL https://deb.nodesource.com/setup_10.x | bash -

/etc/apt/sources.list.d/resilio-sync.list:
	curl -L https://linux-packages.resilio.com/resilio-sync/key.asc | apt-key add -
	echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" > /etc/apt/sources.list.d/resilio-sync.list

install: $(executables)

$(executables):
	DEBIAN_FRONTEND=noninteractive apt install -y openvpn xinit docker-ce nodejs resilio-sync gzip
	usermod -aG docker $(USER)

