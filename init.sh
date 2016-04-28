cp resources/99force-ipv4 /etc/apt/apt.conf.d/

apt update
apt -y install make

make -f makefiles/init.Makefile
