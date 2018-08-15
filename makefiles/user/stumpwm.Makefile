rcfiles := $(HOME)/.sbclrc $(HOME)/.xinitrc $(HOME)/.stumpwmrc

setup: $(HOME)/workspace/stumpwm

$(HOME)/workspace/stumpwm: $(HOME)/workspace/touch $(rcfiles) /usr/bin/makeinfo /usr/bin/install-info
	git clone https://github.com/stumpwm/stumpwm.git $(HOME)/workspace/stumpwm

/usr/bin/makeinfo /usr/bin/install-info:
	apt install -y texinfo install-info

$(HOME)/.xinitrc:
	echo "$(HOME)/bin/xfix\nexec /usr/local/bin/stumpwm" > $(HOME)/.xinitrc

$(HOME)/.sbclrc:
	curl -O https://beta.quicklisp.org/quicklisp.lisp
	sbcl --load quicklisp.lisp --eval '(quicklisp-quickstart:install)' --eval '(let ((*do-not-prompt* t)) `(ql:add-to-init-file))' --eval '(ql:quickload "clx")' --eval '(ql:quickload "cl-ppcre")' --eval '(ql:quickload "alexandria")' --eval '(quit)'
	echo "#-quicklisp\n(let ((quicklisp-init (merge-pathnames \"quicklisp/setup.lisp\" (user-homedir-pathname))))\n(when (probe-file quicklisp-init)\n(load quicklisp-init)))" > $(HOME)/.sbclrc

$(HOME)/.stumpwmrc:
	echo ";; -*-lisp-*-\n(in-package :stumpwm)\n(setf *mouse-focus-policy* :sloppy)\n(run-shell-command "exec xautolock -detectsleep -time 3 -locker $(HOME)/bin/lock")\n(gnewbg "alt")" > $(HOME)/.stumpwmrc

$(HOME)/workspace/touch:
	mkdir -p $(HOME)/workspace
	touch $(HOME)/workspace/touch

install: /usr/local/bin/stumpwm

/usr/local/bin/stumpwm: $(HOME)/workspace/stumpwm/configure
	echo "exec /usr/local/bin/stumpwm" > ~/.xinitrc
	cd $(HOME)/workspace/stumpwm && ./configure && make && make install

$(HOME)/workspace/stumpwm/configure:
	cd $(HOME)/workspace/stumpwm && autoconf
