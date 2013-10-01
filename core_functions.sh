#!/bin/bash

source core_git_functions.sh
source core_xml_functions.sh
source core_io_functions.sh

jirac_check_dependency() {
	command -v $1 >/dev/null 2>&1 || { echo >&2 log ERROR "${1} is required but is not installed.  Aborting."; exit 1;}
}

jirac_log() {
	if [ $1 = "ERROR" ]; then
		echo "[ERROR] $2";
	elif [ $1 = "INFO" ]; then 
		echo "[INFO] $2";
	elif [ $1 = "DEBUG" ]; then 
		echo "[DEBUG] $2";
	fi
}

jirac_copy_to_clipboard() {
        if [[ $OSTYPE == darwin* ]]; then
                pbcopy < $1
        else
                xclip -sel clip < $1
        fi
}
