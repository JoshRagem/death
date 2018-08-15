setup: $(HOME)/workspace/vimsetup/Makefile

$(HOME)/workspace/vimsetup/Makefile: $(HOME)/workspace/touch
	git clone https://github.com/joshragem/vimsetup.git $(HOME)/workspace/vimsetup

$(HOME)/workspace/touch:
	mkdir -p $(HOME)/workspace
	touch $(HOME)/workspace/touch

install: $(HOME)/.vimrc

$(HOME)/.vimrc: $(HOME)/workspace/vimsetup/Makefile
	cd $(HOME)/workspace/vimsetup && make && make install
