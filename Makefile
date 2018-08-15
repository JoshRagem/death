.DEFAULT_GOAL := install
makefiles := $(wildcard makefiles/*.Makefile)

release: build/touch
	tar -cf build/death.tar bin makefiles resources templates

build/touch:
	mkdir -p build
	touch build/touch

install: install.log setup.log

install.log: setup.log
	touch install.log.hold
	truncate --size=0 install.log.hold
	$(foreach mk,$(makefiles),make -f $(mk) install | tee -a install.log.hold;)
	mv install.log.hold install.log

setup: setup.log

setup.log:
	touch setup.log.hold
	truncate --size=0 setup.log.hold
	$(foreach mk,$(makefiles),make -f $(mk) setup | tee -a setup.log.hold;)
	mv setup.log.hold setup.log

state/touch:
	mkdir -p state
	touch state/touch

.PHONY: buildstate
buildstate:
	$(foreach mk,$(makefiles),make -f $(mk) upsert_version | tee -a install.log;)

.PHONY: clean
clean:
	rm -rf state/* install.log
	rm ./*.hold
	$(foreach mk,$(makefiles),make -f $(mk) clean;)
