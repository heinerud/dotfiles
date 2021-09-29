#!/bin/sh

case "$1" in
	*.tgz|*.tar.gz) tar tzf "$1";;
	*.tar.bz2|*.tbz2) tar tjf "$1";;
	*.tar.txz|*.txz) xz --list "$1";;
	*.tar) tar tf "$1";;
	*.zip) unzip -l "$1";;
	*) highlight --out-format ansi "$1" || cat "$1";;
esac
