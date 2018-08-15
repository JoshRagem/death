FROM ubuntu:bionic
RUN apt update
RUN apt upgrade -y
RUN apt install -y make
COPY . ./
RUN make
