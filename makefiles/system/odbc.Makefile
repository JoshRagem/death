setup:

install: /usr/bin/odbcinst

/usr/bin/odbcinst: /usr/bin/gpg
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 93DB296A69BE019A
	apt install -y odbcinst

