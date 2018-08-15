FROM ubuntu:bionic
RUN apt update
RUN apt upgrade -y
RUN apt install -y make
COPY Makefile ./
COPY makefiles/system ./makefiles/system
COPY resources ./resources
RUN make install_system
COPY makefiles/user ./makefiles/user
RUN make install_user
