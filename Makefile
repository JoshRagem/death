
build/death.tar: build bin files init.sh makefiles resources secrets templates
	tar -cf build/death.tar bin files init.sh makefiles resources secrets templates

build:
	mkdir build
