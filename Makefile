.DEFAULT_GOAL := install
makefiles := $(wildcard makefiles/*.Makefile)

release: build/touch
	tar -cf build/death.tar bin makefiles resources templates

build/touch:
	mkdir -p build
	touch build/touch

install: install.log

install.log: $(wildcard state/**/*) | state/touch buildstate
	$(foreach mk,$(makefiles),make -f $(mk) | tee -a install.log;)

state/touch:
	mkdir -p state
	touch state/touch

.PHONY: buildstate
buildstate:
	$(foreach mk,$(makefiles),make -f $(mk) upsert_version | tee -a install.log;)

.PHONY: clean
clean:
	rm -rf state/* install.log
	$(foreach mk,$(makefiles),make -f $(mk) clean;)
