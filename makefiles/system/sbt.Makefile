CODENAME := $(shell cat /etc/lsb-release | grep CODENAME | cut -d '=' -f 2)

setup: /etc/apt/sources.list.d/sbt.list /etc/apt/sources.list.d/java.list

/etc/apt/sources.list.d/sbt.list: /usr/bin/gpg2
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
	echo "deb https://dl.bintray.com/sbt/debian /" > /etc/apt/sources.list.d/sbt.list

/etc/apt/sources.list.d/java.list: /usr/bin/gpg2
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA8CACC073C3DB2A
	echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
	echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu $(CODENAME) main" > /etc/apt/sources.list.d/java.list

/usr/bin/gpg2:
	apt install -y gnupg2

install: /usr/bin/sbt /usr/bin/java

/usr/bin/java:
	apt update
	apt install -y oracle-java10-installer

/usr/bin/sbt:
	apt update
	apt install -y sbt

