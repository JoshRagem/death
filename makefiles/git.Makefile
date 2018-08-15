CODENAME := $(shell cat /etc/lsb-release | grep CODENAME | cut -d '=' -f 2)

setup: /etc/apt/sources.list.d/git-core.list

/etc/apt/sources.list.d/git-core.list: /usr/bin/gpg2
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv A1715D88E1DF1F24
	echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu $(CODENAME) main" > /etc/apt/sources.list.d/git-core.list

/usr/bin/gpg2:
	apt install -y gnupg2

install: /usr/bin/git

/usr/bin/git:
	rm /usr/bin/git
	apt install -y git

