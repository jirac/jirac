#!/bin/bash

source "$jirac_dir"/core_git_functions.sh
source "$jirac_dir"/core_xml_functions.sh
source "$jirac_dir"/core_io_functions.sh

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
        elif [[ $OSTYPE == msys ]]; then
                clip < $1
        else
                xclip -sel clip < $1
        fi
}

create_editor_variable(){
    editor=$VISUAL
    editor=${editor:-$EDITOR}

    if [ -z "$editor" ]; then
        jirac_log ERROR 'Please export $VISUAL or $EDITOR as your favourite text editor'
        exit 1
    fi
}
