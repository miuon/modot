#!/bin/bash

dunstConf=$HOME/.config/dunst

print_usage() {
	printf "Usage: no arguments\nShould be run from MODOT
Required environment variables:
\tMODOT_COMMON: directory of common files for this module
\tMODOT_HOST: directory of host files for this module
\tMODOT_THEME: directory of built theme files for this module
Optional environment variables:
\tMODOT_QUICK: true -- quick reload, false -- full restart\n"
}

if [ $# -gt 1 ] || [ -z $MODOT_COMMON ] || \
	[ -z $MODOT_HOST ] || [ -z $MODOT_THEME ] ; then
	print_usage ; exit 1 ;
fi

commonDir=`realpath $MODOT_COMMON`
hostDir=`realpath $MODOT_HOST`
themeDir=`realpath $MODOT_THEME`
isQuick=$MODOT_QUICK

mkdir -p $dunstConf >/dev/null
ln -sf $themeDir/dunstrc $dunstConf/dunstrc

if [ "$isQuick" = true ]; then
	echo "reloading dunst"
	pkill -x dunst
	dunst >/dev/null 2>/dev/null &
else
	echo "restarting dunst"
	pkill -x dunst
	dunst >/dev/null 2>/dev/null &
fi
