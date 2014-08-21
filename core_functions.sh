#!/bin/bash

source "$jirac_dir"/core_git_functions.sh
source "$jirac_dir"/core_xml_functions.sh
source "$jirac_dir"/core_io_functions.sh

jirac_check_dependency() {
    jirac_log DEBUG " checking $1..."
	command -v $1 >/dev/null 2>&1 || message_and_exit "${1} is required but is not installed. Aborting."
}

jirac_log() {
    log_type=$1
    log_description=$2

    case $log_type in
        "ERROR" )
            test $log_level -gt -1 && echo "[ERROR] $log_description" >&2
            ;;
        "INFO" )
            test $log_level -gt 0 && echo "[INFO ] $log_description"
            ;;
        "DEBUG" )
            test $log_level -gt 1 && echo "[DEBUG] $log_description"
            ;;
    esac
}

jirac_copy_to_clipboard() {
    if [[ $OSTYPE == darwin* ]]; then
        pbcopy < $1
    elif [ $OSTYPE == msys ]; then
        clip < $1
    else
        xclip -sel clip < $1
    fi
}

create_editor_variable(){
    editor=$VISUAL
    editor=${editor:-$EDITOR}

    if [ -z "$editor" ]; then
        message_and_exit 'Please export $VISUAL or $EDITOR as your favourite text editor'
    fi
}

reverse_commits() {
    if [[ $OSTYPE == darwin* ]]; then
        gtac --separator=" "
    else
        tac --separator=" "
    fi
}

usage_and_exit(){
    test -n "$1" && jirac_log ERROR "$1"
    jirac_help
    exit 1
}

message_and_exit(){
    test -n "$1" && jirac_log ERROR "$1"
    exit 1
}
