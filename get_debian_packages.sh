#!/bin/bash

# Get some packages we need in Debian.
# Run this as sudo.

apt-get update && apt-get upgrade

apt-get install -y --no-install-recommends \
        apt-utils \
	curl \
	emacs \
	ffmpeg \
	git \
	net-tools \
        perl \
	unzip \
	v4l-utils \
	wget

