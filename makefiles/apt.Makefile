executables := /usr/bin/openssl /usr/bin/gpg2 /usr/bin/curl

setup:

install: /usr/bin/openssl /usr/bin/gpg2 /usr/bin/curl

$(executables):
	apt install -y apt-transport-https gnupg2 curl
