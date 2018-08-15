.DEFAULT_GOAL := install
sysmakefiles := $(wildcard makefiles/system/*.Makefile)
usrmakefiles := $(wildcard makefiles/user/*.Makefile)

release: build/touch
	tar -cf build/death.tar bin makefiles resources templates

build/touch:
	mkdir -p build
	touch build/touch

install: install_user

install_user: install_system user.log

install_system: install.log

install.log: setup.log
	touch install.log.hold
	truncate --size=0 install.log.hold
	$(foreach mk,$(sysmakefiles),make -f $(mk) install | tee -a install.log.hold;)
	mv install.log.hold install.log

setup: setup.log

setup.log:
	touch setup.log.hold
	truncate --size=0 setup.log.hold
	$(foreach mk,$(sysmakefiles),make -f $(mk) setup | tee -a setup.log.hold;)
	mv setup.log.hold setup.log

user.log: usersetup.log
	touch user.log.hold
	truncate --size=0 user.log.hold
	$(foreach mk,$(usrmakefiles),make -f $(mk) install | tee -a user.log.hold;)
	mv user.log.hold user.log

usersetup.log:
	touch usersetup.log.hold
	truncate --size=0 user.log.hold
	$(foreach mk,$(usrmakefiles),make -f $(mk) setup | tee -a usersetup.log.hold;)
	mv usersetup.log.hold usersetup.log
