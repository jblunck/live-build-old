#!/bin/sh

LH_BASE="${LH_BASE:-/usr/share/live-helper}"

# Source global functions
for FUNCTION in "${LH_BASE}"/functions/*.sh
do
	. "${FUNCTION}"
done

# Source global helpers
for HELPER in "${LH_BASE}"/helpers/*
do
	. "${HELPER}"
done

# Source local functions
if ls auto/functions/* > /dev/null 2>&1
then
	for FUNCTION in auto/functions/*
	do
		. "${FUNCTION}"
	done
fi
