#!/bin/sh

## live-build(7) - System Build Scripts
## Copyright (C) 2006-2010 Daniel Baumann <daniel@debian.org>
##
## live-build comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
## This is free software, and you are welcome to redistribute it
## under certain conditions; see COPYING for details.


PACKAGE="live-build"
VERSION="2.0.0-1"
CONFIG_VERSION="$(echo ${VERSION} | awk -F- '{ print $1 }')"

PATH="${PWD}/auto/scripts:${PATH}"
