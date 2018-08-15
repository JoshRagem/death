CODENAME := $(shell cat /etc/lsb-release | grep CODENAME | cut -d '=' -f 2)
USER := $(shell whoami)

executables := /usr/sbin/openvpn /usr/bin/startx /usr/bin/shutter /usr/bin/docker /usr/bin/node /usr/bin/resilio-sync /bin/gunzip /usr/bin/kubectl
lists := /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/nodesource.list /etc/apt/sources.list.d/resilio-sync.list /etc/apt/sources.list.d/kubernetes.list

setup: $(lists)
	apt update
	apt-get install -y apt-transport-https ca-certificates curl software-properties-common

/etc/apt/sources.list.d/docker.list:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(CODENAME) edge" > /etc/apt/sources.list.d/docker.list

/etc/apt/sources.list.d/nodesource.list:
	curl -sL https://deb.nodesource.com/setup_10.x | bash -

/etc/apt/sources.list.d/resilio-sync.list:
	curl -L https://linux-packages.resilio.com/resilio-sync/key.asc | apt-key add -
	echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" > /etc/apt/sources.list.d/resilio-sync.list

/etc/apt/sources.list.d/kubernetes.list:
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

install: $(executables)

$(executables):
	DEBIAN_FRONTEND=noninteractive apt install -y openvpn xinit shutter docker-ce nodejs resilio-sync gzip kubectl
	usermod -aG docker $(USER)

