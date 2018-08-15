executables := /usr/bin/openssl /usr/bin/gpg2 /usr/bin/curl /usr/bin/vim /usr/local/bin/firefox /usr/bin/sbcl

setup:

install: $(executables)

$(executables):
	apt install -y apt-transport-https gnupg2 curl vim firefox sbcl
