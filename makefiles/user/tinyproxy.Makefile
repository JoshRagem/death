setup: $(HOME)/workspace/tinyproxy/configure

$(HOME)/workspace/tinyproxy/configure:
	cd $(HOME)/workspace && git clone https://github.com/tinyproxy/tinyproxy.git
	cd $(HOME)/workspace/tinyproxy && ./autogen.sh

install: /usr/sbin/tinyproxy

/usr/sbin/tinyproxy:
	cd $(HOME)/workspace/tinyproxy && ./configure --enable-xtinyproxy --enable-filter --enable-upstream --enable-transparent && make && make install
